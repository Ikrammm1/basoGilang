import axios from "../../../axios/index.js";
import store from "../../../../store/store.js";
import jwt from "jsonwebtoken";

const jwtConfig = {
    secret: "L4w5On_M1ns",
    expireTime: 8000,
};

// Token Refresh
let isAlreadyFetchingAccessToken = false;
let subscribers = [];

function onAccessTokenFetched(access_token) {
    subscribers = subscribers.filter((callback) => callback(access_token));
}

function addSubscriber(callback) {
    subscribers.push(callback);
}

export default {
    init() {
        axios.interceptors.response.use(
            function (response) {
                return response;
            },
            function (error) {
                // const { config, response: { status } } = error
                const { config, response } = error;
                const originalRequest = config;

                // if (status === 401) {
                if (response && response.status === 401) {
                    if (!isAlreadyFetchingAccessToken) {
                        isAlreadyFetchingAccessToken = true;
                        store
                            .dispatch("auth/fetchAccessToken")
                            .then((access_token) => {
                                isAlreadyFetchingAccessToken = false;
                                onAccessTokenFetched(access_token);
                            });
                    }

                    const retryOriginalRequest = new Promise((resolve) => {
                        addSubscriber((access_token) => {
                            originalRequest.headers.Authorization =
                                "Bearer " + access_token;
                            resolve(axios(originalRequest));
                        });
                    });
                    return retryOriginalRequest;
                }
                return Promise.reject(error);
            }
        );
    },
    login(username, password, remember_me) {
        let error = "Something went wrong";

        if (remember_me) {
            jwtConfig.expireTime = jwtConfig.expireTime * 1000;
        }

        return axios
            .post("/api/auth/login", {
                username: username,
                password: password,
            })
            .then((response) => {
                if (
                    response.data.result == "T" ||
                    response.data.result == "E"
                ) {
                    try {
                        const accessToken = jwt.sign(
                            {
                                id: response.data.ps_nik,
                            },
                            jwtConfig.secret,
                            {
                                expiresIn: jwtConfig.expireTime,
                            }
                        );

                        const userData = Object.assign({}, response.data, {
                            providerId: "jwt",
                        });

                        var tokenExpiry = new Date();
                        tokenExpiry.setMinutes(
                            tokenExpiry.getMinutes() + jwtConfig.expireTime / 60
                        );

                        const responses = {
                            userData: userData,
                            accessToken: accessToken,
                            tokenExpiry: tokenExpiry,
                            localStorageKey: "true",
                        };

                        return [200, responses];
                    } catch (e) {
                        error = e;
                    }
                } else {
                    error =
                        Object.keys(response.data).length != 0 && response.data
                            ? "Email Or Password Invalid"
                            : "User not Found";
                }

                return [
                    200,
                    {
                        error,
                    },
                ];
            })
            .catch((error) => {
                Promise.reject(error);
            });
    },
    refreshToken() {
        const accessToken = localStorage.getItem("accessToken");

        var users = localStorage.getItem("userInfo");

        try {
            const { id } = jwt.verify(accessToken, jwtConfig.secret);

            let userData = Object.assign(
                {},
                users.find((user) => user.uid === id)
            );

            const newAccessToken = jwt.sign(
                {
                    id: userData.uid,
                },
                jwtConfig.secret,
                {
                    expiresIn: jwtConfig.expiresIn,
                }
            );

            const response = {
                userData: userData,
                accessToken: newAccessToken,
            };

            return [200, response];
        } catch (e) {
            const error = "Invalid access token";
            return [
                401,
                {
                    error,
                },
            ];
        }
    },
};
