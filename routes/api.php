<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\MenuManagement\MenuController;
use App\Http\Controllers\AuthorizationsGroup\AuthorizationsController;
use App\Http\Controllers\UserApp\UserAppController;
use App\Http\Controllers\PositionUser\PositionController;
use App\Http\Controllers\Category\CategoryController;
use App\Http\Controllers\Product\ProductController;
use App\Http\Controllers\VendorManagement\VendorController;
use App\Http\Controllers\BahanBaku\BahanBakuController;
use App\Http\Controllers\BahanKemasan\BahanKemasanController;
use App\Http\Controllers\Produksi\ProduksiController;
use App\Http\Controllers\Packaging\PackagingController;
use App\Http\Controllers\Ongkir\OngkirController;
use App\Http\Controllers\Customer\CustomerController;
use App\Http\Controllers\Stock\StockController;
use App\Http\Controllers\Transaction\TransactionController;
use App\Http\Controllers\Report\ReportController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');

Route::post('/menu-management/menuList', [MenuController::class, 'index']);
Route::post('/menu-management/list', [MenuController::class, 'getMenuAuth']);
Route::post('/menu-management/getParent/{cat}', [MenuController::class, 'getParent']);
Route::post('/menu-management/add/', [MenuController::class, 'store']);
Route::post('/menu-management/update/', [MenuController::class, 'update']);
Route::post('/menu-management/delete/', [MenuController::class, 'delete']);


//Authorizations
Route::post('/authorization-group/list', [AuthorizationsController::class, 'index']);
Route::post('/authorization-group/add/', [AuthorizationsController::class, 'store']);
Route::post('/authorization-group/update/', [AuthorizationsController::class, 'update']);
Route::post('/authorization-group/delete/', [AuthorizationsController::class, 'delete']);

//Users
Route::post('/userApp/listUser', [UserAppController::class, 'listUser']);
Route::post('/userApp/add/', [UserAppController::class, 'store']);
Route::post('/userApp/update/', [UserAppController::class, 'update']);
Route::post('/userApp/newPass/', [UserAppController::class, 'newPass']);
Route::delete('/userApp/delete/{id}', [UserAppController::class, 'delete']);
Route::post('/userApp/getPositions', [UserAppController::class, 'getPositions']);
Route::post('/userApp/upload', [UserAppController::class, 'upload']);

//positions
Route::post('/position/list', [PositionController::class, 'index']);
Route::post('/position/add/', [PositionController::class, 'store']);
Route::post('/position/update/', [PositionController::class, 'update']);
Route::delete('/position/delete/{id}', [PositionController::class, 'delete']);


//category
Route::post('/category/list', [CategoryController::class, 'index']);
Route::post('/category/add/', [CategoryController::class, 'store']);
Route::post('/category/update/', [CategoryController::class, 'update']);
Route::delete('/category/delete/{id}', [CategoryController::class, 'delete']);

//product
Route::post('/product/list', [ProductController::class, 'index']);
Route::post('/product/add/', [ProductController::class, 'store']);
Route::post('/product/update/', [ProductController::class, 'update']);
Route::delete('/product/delete/{id}', [ProductController::class, 'delete']);

//vendor
Route::post('/vendor/list', [VendorController::class, 'index']);
Route::post('/vendor/add/', [VendorController::class, 'store']);
Route::post('/vendor/update/', [VendorController::class, 'update']);
Route::delete('/vendor/delete/{id}', [VendorController::class, 'delete']);

//bahan baku
Route::post('/bahanBaku/list', [BahanBakuController::class, 'index']);
Route::post('/bahanBaku/add/', [BahanBakuController::class, 'store']);
Route::post('/bahanBaku/update/', [BahanBakuController::class, 'update']);
Route::delete('/bahanBaku/delete/{id}', [BahanBakuController::class, 'delete']);

Route::post('/bahanBaku/restock/list', [BahanBakuController::class, 'listLogs']);
Route::post('bahanBaku/restock/add', [BahanBakuController::class, 'addLog']);
Route::post('/bahanBaku/restock/update/', [BahanBakuController::class, 'updateLog']);
Route::delete('/bahanBaku/restock/delete/{id}', [BahanBakuController::class, 'deleteLog']);

Route::post('/bahanBaku/stock/list', [BahanBakuController::class, 'getAllStock']);
Route::post('/bahanBaku/stock/getStock', [BahanBakuController::class, 'getStock']);
Route::post('/bahanBaku/stock/needRestock', [BahanBakuController::class, 'getNeedRestock']);


//bahan kemasan
Route::post('/bahanKemasan/list', [BahanKemasanController::class, 'index']);
Route::post('/bahanKemasan/add/', [BahanKemasanController::class, 'store']);
Route::post('/bahanKemasan/update/', [BahanKemasanController::class, 'update']);
Route::delete('/bahanKemasan/delete/{id}', [BahanKemasanController::class, 'delete']);
Route::post('/bahanKemasan/stock/needRestock', [BahanKemasanController::class, 'getNeedRestock']);


Route::post('/bahanKemasan/restock/list', [BahanKemasanController::class, 'listLogs']);
Route::post('bahanKemasan/restock/add', [BahanKemasanController::class, 'addLog']);
Route::post('/bahanKemasan/restock/update/', [BahanKemasanController::class, 'updateLog']);
Route::delete('/bahanKemasan/restock/delete/{id}', [BahanKemasanController::class, 'deleteLog']);

Route::post('/bahanKemasan/stock/list', [BahanKemasanController::class, 'getAllStock']);
Route::post('/bahanKemasan/stock/getStock', [BahanKemasanController::class, 'getStock']);



//produksi
Route::post('/produksi/list', [ProduksiController::class, 'index']);
Route::post('/produksi/add/', [ProduksiController::class, 'store']);
Route::post('/produksi/update/', [ProduksiController::class, 'update']);
Route::delete('/produksi/delete/{id}', [ProduksiController::class, 'delete']);

Route::post('/produksi/restock/list', [ProduksiController::class, 'listLogs']);
Route::post('produksi/restock/add', [ProduksiController::class, 'addLog']);
Route::post('/produksi/restock/update/', [ProduksiController::class, 'updateLog']);
Route::delete('/produksi/restock/delete/{id}', [ProduksiController::class, 'deleteLog']);

Route::post('/bahanKemasan/stock/list', [BahanKemasanController::class, 'getAllStock']);


//packaging
Route::post('/packaging/list', [PackagingController::class, 'index']);
Route::post('/packaging/add/', [PackagingController::class, 'store']);
Route::post('/packaging/update/', [PackagingController::class, 'update']);
Route::delete('/packaging/delete/{id}', [PackagingController::class, 'delete']);

//ongkir
Route::post('/ongkir/list', [OngkirController::class, 'index']);
Route::post('/ongkir/add/', [OngkirController::class, 'store']);
Route::post('/ongkir/update/', [OngkirController::class, 'update']);
Route::delete('/ongkir/delete/{id}', [OngkirController::class, 'delete']);

//ongkir
Route::post('/customer/list', [CustomerController::class, 'index']);
Route::post('/customer/add/', [CustomerController::class, 'store']);
Route::post('/customer/update/', [CustomerController::class, 'update']);
Route::delete('/customer/delete/{id}', [CustomerController::class, 'delete']);
Route::post('/customer/getProv', [CustomerController::class, 'getProvinces']);
Route::post('/customer/getKab/{codeProv}', [CustomerController::class, 'getRegencies']);
Route::post('/customer/getKec/{codeKab}', [CustomerController::class, 'getKec']);

//Stock
Route::post('/stock/list', [StockController::class, 'index']);
Route::post('/stock/add/', [StockController::class, 'store']);
Route::post('/stock/update/', [StockController::class, 'update']);
Route::delete('/stock/delete/{id}', [StockController::class, 'delete']);

//Transaction
Route::post('/transaction/list', [TransactionController::class, 'index']);
Route::post('/transaction/add/', [TransactionController::class, 'store']);
Route::post('/transaction/update/', [TransactionController::class, 'update']);
Route::post('/transaction/delete/{id}', [TransactionController::class, 'delete']);
Route::post('/stock/available/{category}', [StockController::class, 'stockAvailable']);
Route::post('/transaction/todayList', [TransactionController::class, 'todayList']);
Route::post('/transaction/pendingList', [TransactionController::class, 'pendingList']);
Route::post('/transaction/weeklySummary', [TransactionController::class, 'weeklySummary']);
Route::post('/transaction/weeklyIncomeStats', [TransactionController::class, 'weeklyIncomeStats']);

//report

Route::post('/report/getReport', [ReportController::class, 'getReport']);
Route::post('/report/getExpenses', [ReportController::class, 'getExpenses']);














