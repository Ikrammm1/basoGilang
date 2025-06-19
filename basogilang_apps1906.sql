-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.4.3 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table basogilang_apps.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cache: ~9 rows (approximately)
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
	('districts_', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:0:{}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1749542907),
	('districts_31.74', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:10:{i:0;a:2:{s:4:"code";s:8:"31.74.06";s:4:"name";s:8:"Cilandak";}i:1;a:2:{s:4:"code";s:8:"31.74.09";s:4:"name";s:9:"Jagakarsa";}i:2;a:2:{s:4:"code";s:8:"31.74.07";s:4:"name";s:14:"Kebayoran Baru";}i:3;a:2:{s:4:"code";s:8:"31.74.05";s:4:"name";s:14:"Kebayoran Lama";}i:4;a:2:{s:4:"code";s:8:"31.74.03";s:4:"name";s:16:"Mampang Prapatan";}i:5;a:2:{s:4:"code";s:8:"31.74.08";s:4:"name";s:8:"Pancoran";}i:6;a:2:{s:4:"code";s:8:"31.74.04";s:4:"name";s:12:"Pasar Minggu";}i:7;a:2:{s:4:"code";s:8:"31.74.10";s:4:"name";s:12:"Pesanggrahan";}i:8;a:2:{s:4:"code";s:8:"31.74.02";s:4:"name";s:9:"Setiabudi";}i:9;a:2:{s:4:"code";s:8:"31.74.01";s:4:"name";s:5:"Tebet";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750327164),
	('districts_32.01', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:40:{i:0;a:2:{s:4:"code";s:8:"32.01.05";s:4:"name";s:14:"Babakan Madang";}i:1;a:2:{s:4:"code";s:8:"32.01.13";s:4:"name";s:11:"Bojong Gede";}i:2;a:2:{s:4:"code";s:8:"32.01.27";s:4:"name";s:8:"Caringin";}i:3;a:2:{s:4:"code";s:8:"32.01.08";s:4:"name";s:5:"Cariu";}i:4;a:2:{s:4:"code";s:8:"32.01.15";s:4:"name";s:7:"Ciampea";}i:5;a:2:{s:4:"code";s:8:"32.01.24";s:4:"name";s:5:"Ciawi";}i:6;a:2:{s:4:"code";s:8:"32.01.01";s:4:"name";s:8:"Cibinong";}i:7;a:2:{s:4:"code";s:8:"32.01.16";s:4:"name";s:12:"Cibungbulang";}i:8;a:2:{s:4:"code";s:8:"32.01.38";s:4:"name";s:9:"Cigombong";}i:9;a:2:{s:4:"code";s:8:"32.01.22";s:4:"name";s:7:"Cigudeg";}i:10;a:2:{s:4:"code";s:8:"32.01.28";s:4:"name";s:7:"Cijeruk";}i:11;a:2:{s:4:"code";s:8:"32.01.07";s:4:"name";s:9:"Cileungsi";}i:12;a:2:{s:4:"code";s:8:"32.01.29";s:4:"name";s:6:"Ciomas";}i:13;a:2:{s:4:"code";s:8:"32.01.25";s:4:"name";s:7:"Cisarua";}i:14;a:2:{s:4:"code";s:8:"32.01.33";s:4:"name";s:7:"Ciseeng";}i:15;a:2:{s:4:"code";s:8:"32.01.03";s:4:"name";s:9:"Citeureup";}i:16;a:2:{s:4:"code";s:8:"32.01.30";s:4:"name";s:7:"Dramaga";}i:17;a:2:{s:4:"code";s:8:"32.01.02";s:4:"name";s:12:"Gunung Putri";}i:18;a:2:{s:4:"code";s:8:"32.01.11";s:4:"name";s:13:"Gunung Sindur";}i:19;a:2:{s:4:"code";s:8:"32.01.19";s:4:"name";s:7:"Jasinga";}i:20;a:2:{s:4:"code";s:8:"32.01.06";s:4:"name";s:7:"Jonggol";}i:21;a:2:{s:4:"code";s:8:"32.01.12";s:4:"name";s:6:"Kemang";}i:22;a:2:{s:4:"code";s:8:"32.01.32";s:4:"name";s:12:"Klapanunggal";}i:23;a:2:{s:4:"code";s:8:"32.01.14";s:4:"name";s:10:"Leuwiliang";}i:24;a:2:{s:4:"code";s:8:"32.01.39";s:4:"name";s:11:"Leuwisadeng";}i:25;a:2:{s:4:"code";s:8:"32.01.26";s:4:"name";s:11:"Megamendung";}i:26;a:2:{s:4:"code";s:8:"32.01.21";s:4:"name";s:8:"Nanggung";}i:27;a:2:{s:4:"code";s:8:"32.01.17";s:4:"name";s:9:"Pamijahan";}i:28;a:2:{s:4:"code";s:8:"32.01.10";s:4:"name";s:6:"Parung";}i:29;a:2:{s:4:"code";s:8:"32.01.20";s:4:"name";s:14:"Parung Panjang";}i:30;a:2:{s:4:"code";s:8:"32.01.34";s:4:"name";s:12:"Ranca Bungur";}i:31;a:2:{s:4:"code";s:8:"32.01.18";s:4:"name";s:6:"Rumpin";}i:32;a:2:{s:4:"code";s:8:"32.01.35";s:4:"name";s:8:"Sukajaya";}i:33;a:2:{s:4:"code";s:8:"32.01.09";s:4:"name";s:10:"Sukamakmur";}i:34;a:2:{s:4:"code";s:8:"32.01.04";s:4:"name";s:8:"Sukaraja";}i:35;a:2:{s:4:"code";s:8:"32.01.37";s:4:"name";s:11:"Tajurhalang";}i:36;a:2:{s:4:"code";s:8:"32.01.31";s:4:"name";s:9:"Tamansari";}i:37;a:2:{s:4:"code";s:8:"32.01.36";s:4:"name";s:11:"Tanjungsari";}i:38;a:2:{s:4:"code";s:8:"32.01.23";s:4:"name";s:5:"Tenjo";}i:39;a:2:{s:4:"code";s:8:"32.01.40";s:4:"name";s:9:"Tenjolaya";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750201722),
	('districts_32.04', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:31:{i:0;a:2:{s:4:"code";s:8:"32.04.16";s:4:"name";s:8:"Arjasari";}i:1;a:2:{s:4:"code";s:8:"32.04.32";s:4:"name";s:9:"Baleendah";}i:2;a:2:{s:4:"code";s:8:"32.04.13";s:4:"name";s:8:"Banjaran";}i:3;a:2:{s:4:"code";s:8:"32.04.08";s:4:"name";s:11:"Bojongsoang";}i:4;a:2:{s:4:"code";s:8:"32.04.44";s:4:"name";s:9:"Cangkuang";}i:5;a:2:{s:4:"code";s:8:"32.04.25";s:4:"name";s:10:"Cicalengka";}i:6;a:2:{s:4:"code";s:8:"32.04.27";s:4:"name";s:9:"Cikancung";}i:7;a:2:{s:4:"code";s:8:"32.04.07";s:4:"name";s:11:"Cilengkrang";}i:8;a:2:{s:4:"code";s:8:"32.04.05";s:4:"name";s:8:"Cileunyi";}i:9;a:2:{s:4:"code";s:8:"32.04.17";s:4:"name";s:7:"Cimaung";}i:10;a:2:{s:4:"code";s:8:"32.04.06";s:4:"name";s:8:"Cimenyan";}i:11;a:2:{s:4:"code";s:8:"32.04.29";s:4:"name";s:7:"Ciparay";}i:12;a:2:{s:4:"code";s:8:"32.04.39";s:4:"name";s:7:"Ciwidey";}i:13;a:2:{s:4:"code";s:8:"32.04.12";s:4:"name";s:11:"Dayeuhkolot";}i:14;a:2:{s:4:"code";s:8:"32.04.36";s:4:"name";s:4:"Ibun";}i:15;a:2:{s:4:"code";s:8:"32.04.11";s:4:"name";s:8:"Katapang";}i:16;a:2:{s:4:"code";s:8:"32.04.31";s:4:"name";s:9:"Kertasari";}i:17;a:2:{s:4:"code";s:8:"32.04.46";s:4:"name";s:12:"Kutawaringin";}i:18;a:2:{s:4:"code";s:8:"32.04.33";s:4:"name";s:8:"Majalaya";}i:19;a:2:{s:4:"code";s:8:"32.04.10";s:4:"name";s:9:"Margaasih";}i:20;a:2:{s:4:"code";s:8:"32.04.09";s:4:"name";s:9:"Margahayu";}i:21;a:2:{s:4:"code";s:8:"32.04.26";s:4:"name";s:6:"Nagreg";}i:22;a:2:{s:4:"code";s:8:"32.04.30";s:4:"name";s:5:"Pacet";}i:23;a:2:{s:4:"code";s:8:"32.04.14";s:4:"name";s:11:"Pameungpeuk";}i:24;a:2:{s:4:"code";s:8:"32.04.15";s:4:"name";s:11:"Pangalengan";}i:25;a:2:{s:4:"code";s:8:"32.04.35";s:4:"name";s:5:"Paseh";}i:26;a:2:{s:4:"code";s:8:"32.04.38";s:4:"name";s:10:"Pasirjambu";}i:27;a:2:{s:4:"code";s:8:"32.04.40";s:4:"name";s:9:"Rancabali";}i:28;a:2:{s:4:"code";s:8:"32.04.28";s:4:"name";s:9:"Rancaekek";}i:29;a:2:{s:4:"code";s:8:"32.04.34";s:4:"name";s:12:"Solokanjeruk";}i:30;a:2:{s:4:"code";s:8:"32.04.37";s:4:"name";s:7:"Soreang";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750201722),
	('districts_32.17', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:16:{i:0;a:2:{s:4:"code";s:8:"32.17.09";s:4:"name";s:9:"Batujajar";}i:1;a:2:{s:4:"code";s:8:"32.17.10";s:4:"name";s:10:"Cihampelas";}i:2;a:2:{s:4:"code";s:8:"32.17.04";s:4:"name";s:13:"Cikalongwetan";}i:3;a:2:{s:4:"code";s:8:"32.17.11";s:4:"name";s:7:"Cililin";}i:4;a:2:{s:4:"code";s:8:"32.17.07";s:4:"name";s:7:"Cipatat";}i:5;a:2:{s:4:"code";s:8:"32.17.05";s:4:"name";s:10:"Cipeundeuy";}i:6;a:2:{s:4:"code";s:8:"32.17.12";s:4:"name";s:9:"Cipongkor";}i:7;a:2:{s:4:"code";s:8:"32.17.03";s:4:"name";s:7:"Cisarua";}i:8;a:2:{s:4:"code";s:8:"32.17.15";s:4:"name";s:10:"Gununghalu";}i:9;a:2:{s:4:"code";s:8:"32.17.01";s:4:"name";s:7:"Lembang";}i:10;a:2:{s:4:"code";s:8:"32.17.06";s:4:"name";s:8:"Ngamprah";}i:11;a:2:{s:4:"code";s:8:"32.17.08";s:4:"name";s:10:"Padalarang";}i:12;a:2:{s:4:"code";s:8:"32.17.02";s:4:"name";s:10:"Parongpong";}i:13;a:2:{s:4:"code";s:8:"32.17.13";s:4:"name";s:6:"Rongga";}i:14;a:2:{s:4:"code";s:8:"32.17.16";s:4:"name";s:8:"Saguling";}i:15;a:2:{s:4:"code";s:8:"32.17.14";s:4:"name";s:12:"Sindangkerta";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750385565),
	('districts_32.73', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:30:{i:0;a:2:{s:4:"code";s:8:"32.73.05";s:4:"name";s:5:"Andir";}i:1;a:2:{s:4:"code";s:8:"32.73.20";s:4:"name";s:8:"Antapani";}i:2;a:2:{s:4:"code";s:8:"32.73.24";s:4:"name";s:9:"Arcamanik";}i:3;a:2:{s:4:"code";s:8:"32.73.10";s:4:"name";s:12:"Astana Anyar";}i:4;a:2:{s:4:"code";s:8:"32.73.03";s:4:"name";s:15:"Babakan Ciparay";}i:5;a:2:{s:4:"code";s:8:"32.73.21";s:4:"name";s:13:"Bandung Kidul";}i:6;a:2:{s:4:"code";s:8:"32.73.15";s:4:"name";s:13:"Bandung Kulon";}i:7;a:2:{s:4:"code";s:8:"32.73.09";s:4:"name";s:13:"Bandung Wetan";}i:8;a:2:{s:4:"code";s:8:"32.73.12";s:4:"name";s:11:"Batununggal";}i:9;a:2:{s:4:"code";s:8:"32.73.04";s:4:"name";s:15:"Bojongloa Kaler";}i:10;a:2:{s:4:"code";s:8:"32.73.17";s:4:"name";s:15:"Bojongloa Kidul";}i:11;a:2:{s:4:"code";s:8:"32.73.22";s:4:"name";s:8:"Buahbatu";}i:12;a:2:{s:4:"code";s:8:"32.73.18";s:4:"name";s:16:"Cibeunying Kaler";}i:13;a:2:{s:4:"code";s:8:"32.73.14";s:4:"name";s:16:"Cibeunying Kidul";}i:14;a:2:{s:4:"code";s:8:"32.73.25";s:4:"name";s:6:"Cibiru";}i:15;a:2:{s:4:"code";s:8:"32.73.06";s:4:"name";s:7:"Cicendo";}i:16;a:2:{s:4:"code";s:8:"32.73.08";s:4:"name";s:7:"Cidadap";}i:17;a:2:{s:4:"code";s:8:"32.73.29";s:4:"name";s:7:"Cinambo";}i:18;a:2:{s:4:"code";s:8:"32.73.02";s:4:"name";s:7:"Coblong";}i:19;a:2:{s:4:"code";s:8:"32.73.27";s:4:"name";s:8:"Gedebage";}i:20;a:2:{s:4:"code";s:8:"32.73.16";s:4:"name";s:12:"Kiaracondong";}i:21;a:2:{s:4:"code";s:8:"32.73.13";s:4:"name";s:8:"Lengkong";}i:22;a:2:{s:4:"code";s:8:"32.73.30";s:4:"name";s:11:"Mandalajati";}i:23;a:2:{s:4:"code";s:8:"32.73.28";s:4:"name";s:11:"Panyileukan";}i:24;a:2:{s:4:"code";s:8:"32.73.23";s:4:"name";s:9:"Rancasari";}i:25;a:2:{s:4:"code";s:8:"32.73.11";s:4:"name";s:5:"Regol";}i:26;a:2:{s:4:"code";s:8:"32.73.07";s:4:"name";s:8:"Sukajadi";}i:27;a:2:{s:4:"code";s:8:"32.73.01";s:4:"name";s:8:"Sukasari";}i:28;a:2:{s:4:"code";s:8:"32.73.19";s:4:"name";s:13:"Sumur Bandung";}i:29;a:2:{s:4:"code";s:8:"32.73.26";s:4:"name";s:11:"Ujungberung";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750385564),
	('districts_34.04', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:17:{i:0;a:2:{s:4:"code";s:8:"34.04.08";s:4:"name";s:6:"Berbah";}i:1;a:2:{s:4:"code";s:8:"34.04.17";s:4:"name";s:11:"Cangkringan";}i:2;a:2:{s:4:"code";s:8:"34.04.07";s:4:"name";s:5:"Depok";}i:3;a:2:{s:4:"code";s:8:"34.04.01";s:4:"name";s:7:"Gamping";}i:4;a:2:{s:4:"code";s:8:"34.04.02";s:4:"name";s:6:"Godean";}i:5;a:2:{s:4:"code";s:8:"34.04.10";s:4:"name";s:7:"Kalasan";}i:6;a:2:{s:4:"code";s:8:"34.04.04";s:4:"name";s:7:"Minggir";}i:7;a:2:{s:4:"code";s:8:"34.04.06";s:4:"name";s:5:"Mlati";}i:8;a:2:{s:4:"code";s:8:"34.04.03";s:4:"name";s:7:"Moyudan";}i:9;a:2:{s:4:"code";s:8:"34.04.12";s:4:"name";s:7:"Ngaglik";}i:10;a:2:{s:4:"code";s:8:"34.04.11";s:4:"name";s:8:"Ngemplak";}i:11;a:2:{s:4:"code";s:8:"34.04.16";s:4:"name";s:5:"Pakem";}i:12;a:2:{s:4:"code";s:8:"34.04.09";s:4:"name";s:9:"Prambanan";}i:13;a:2:{s:4:"code";s:8:"34.04.05";s:4:"name";s:7:"Seyegan";}i:14;a:2:{s:4:"code";s:8:"34.04.13";s:4:"name";s:6:"Sleman";}i:15;a:2:{s:4:"code";s:8:"34.04.14";s:4:"name";s:6:"Tempel";}i:16;a:2:{s:4:"code";s:8:"34.04.15";s:4:"name";s:4:"Turi";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750345871),
	('provinces', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:37:{i:0;a:2:{s:4:"code";s:2:"11";s:4:"name";s:4:"Aceh";}i:1;a:2:{s:4:"code";s:2:"51";s:4:"name";s:4:"Bali";}i:2;a:2:{s:4:"code";s:2:"36";s:4:"name";s:6:"Banten";}i:3;a:2:{s:4:"code";s:2:"17";s:4:"name";s:8:"Bengkulu";}i:4;a:2:{s:4:"code";s:2:"34";s:4:"name";s:26:"Daerah Istimewa Yogyakarta";}i:5;a:2:{s:4:"code";s:2:"31";s:4:"name";s:11:"DKI Jakarta";}i:6;a:2:{s:4:"code";s:2:"75";s:4:"name";s:9:"Gorontalo";}i:7;a:2:{s:4:"code";s:2:"15";s:4:"name";s:5:"Jambi";}i:8;a:2:{s:4:"code";s:2:"32";s:4:"name";s:10:"Jawa Barat";}i:9;a:2:{s:4:"code";s:2:"33";s:4:"name";s:11:"Jawa Tengah";}i:10;a:2:{s:4:"code";s:2:"35";s:4:"name";s:10:"Jawa Timur";}i:11;a:2:{s:4:"code";s:2:"61";s:4:"name";s:16:"Kalimantan Barat";}i:12;a:2:{s:4:"code";s:2:"63";s:4:"name";s:18:"Kalimantan Selatan";}i:13;a:2:{s:4:"code";s:2:"62";s:4:"name";s:17:"Kalimantan Tengah";}i:14;a:2:{s:4:"code";s:2:"64";s:4:"name";s:16:"Kalimantan Timur";}i:15;a:2:{s:4:"code";s:2:"65";s:4:"name";s:16:"Kalimantan Utara";}i:16;a:2:{s:4:"code";s:2:"19";s:4:"name";s:25:"Kepulauan Bangka Belitung";}i:17;a:2:{s:4:"code";s:2:"21";s:4:"name";s:14:"Kepulauan Riau";}i:18;a:2:{s:4:"code";s:2:"18";s:4:"name";s:7:"Lampung";}i:19;a:2:{s:4:"code";s:2:"81";s:4:"name";s:6:"Maluku";}i:20;a:2:{s:4:"code";s:2:"82";s:4:"name";s:12:"Maluku Utara";}i:21;a:2:{s:4:"code";s:2:"52";s:4:"name";s:19:"Nusa Tenggara Barat";}i:22;a:2:{s:4:"code";s:2:"53";s:4:"name";s:19:"Nusa Tenggara Timur";}i:23;a:2:{s:4:"code";s:2:"91";s:4:"name";s:5:"Papua";}i:24;a:2:{s:4:"code";s:2:"92";s:4:"name";s:11:"Papua Barat";}i:25;a:2:{s:4:"code";s:2:"95";s:4:"name";s:16:"Papua Pegunungan";}i:26;a:2:{s:4:"code";s:2:"93";s:4:"name";s:13:"Papua Selatan";}i:27;a:2:{s:4:"code";s:2:"94";s:4:"name";s:12:"Papua Tengah";}i:28;a:2:{s:4:"code";s:2:"14";s:4:"name";s:4:"Riau";}i:29;a:2:{s:4:"code";s:2:"76";s:4:"name";s:14:"Sulawesi Barat";}i:30;a:2:{s:4:"code";s:2:"73";s:4:"name";s:16:"Sulawesi Selatan";}i:31;a:2:{s:4:"code";s:2:"72";s:4:"name";s:15:"Sulawesi Tengah";}i:32;a:2:{s:4:"code";s:2:"74";s:4:"name";s:17:"Sulawesi Tenggara";}i:33;a:2:{s:4:"code";s:2:"71";s:4:"name";s:14:"Sulawesi Utara";}i:34;a:2:{s:4:"code";s:2:"13";s:4:"name";s:14:"Sumatera Barat";}i:35;a:2:{s:4:"code";s:2:"16";s:4:"name";s:16:"Sumatera Selatan";}i:36;a:2:{s:4:"code";s:2:"12";s:4:"name";s:14:"Sumatera Utara";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750327060),
	('regencies_31', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:6:{i:0;a:2:{s:4:"code";s:5:"31.01";s:4:"name";s:21:"Kab. Adm. Kep. Seribu";}i:1;a:2:{s:4:"code";s:5:"31.73";s:4:"name";s:23:"Kota Adm. Jakarta Barat";}i:2;a:2:{s:4:"code";s:5:"31.71";s:4:"name";s:23:"Kota Adm. Jakarta Pusat";}i:3;a:2:{s:4:"code";s:5:"31.74";s:4:"name";s:25:"Kota Adm. Jakarta Selatan";}i:4;a:2:{s:4:"code";s:5:"31.75";s:4:"name";s:23:"Kota Adm. Jakarta Timur";}i:5;a:2:{s:4:"code";s:5:"31.72";s:4:"name";s:23:"Kota Adm. Jakarta Utara";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750327164),
	('regencies_32', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:27:{i:0;a:2:{s:4:"code";s:5:"32.04";s:4:"name";s:12:"Kab. Bandung";}i:1;a:2:{s:4:"code";s:5:"32.17";s:4:"name";s:18:"Kab. Bandung Barat";}i:2;a:2:{s:4:"code";s:5:"32.16";s:4:"name";s:11:"Kab. Bekasi";}i:3;a:2:{s:4:"code";s:5:"32.01";s:4:"name";s:10:"Kab. Bogor";}i:4;a:2:{s:4:"code";s:5:"32.07";s:4:"name";s:11:"Kab. Ciamis";}i:5;a:2:{s:4:"code";s:5:"32.03";s:4:"name";s:12:"Kab. Cianjur";}i:6;a:2:{s:4:"code";s:5:"32.09";s:4:"name";s:12:"Kab. Cirebon";}i:7;a:2:{s:4:"code";s:5:"32.05";s:4:"name";s:10:"Kab. Garut";}i:8;a:2:{s:4:"code";s:5:"32.12";s:4:"name";s:14:"Kab. Indramayu";}i:9;a:2:{s:4:"code";s:5:"32.15";s:4:"name";s:13:"Kab. Karawang";}i:10;a:2:{s:4:"code";s:5:"32.08";s:4:"name";s:13:"Kab. Kuningan";}i:11;a:2:{s:4:"code";s:5:"32.10";s:4:"name";s:15:"Kab. Majalengka";}i:12;a:2:{s:4:"code";s:5:"32.18";s:4:"name";s:16:"Kab. Pangandaran";}i:13;a:2:{s:4:"code";s:5:"32.14";s:4:"name";s:15:"Kab. Purwakarta";}i:14;a:2:{s:4:"code";s:5:"32.13";s:4:"name";s:11:"Kab. Subang";}i:15;a:2:{s:4:"code";s:5:"32.02";s:4:"name";s:13:"Kab. Sukabumi";}i:16;a:2:{s:4:"code";s:5:"32.11";s:4:"name";s:13:"Kab. Sumedang";}i:17;a:2:{s:4:"code";s:5:"32.06";s:4:"name";s:16:"Kab. Tasikmalaya";}i:18;a:2:{s:4:"code";s:5:"32.73";s:4:"name";s:12:"Kota Bandung";}i:19;a:2:{s:4:"code";s:5:"32.79";s:4:"name";s:11:"Kota Banjar";}i:20;a:2:{s:4:"code";s:5:"32.75";s:4:"name";s:11:"Kota Bekasi";}i:21;a:2:{s:4:"code";s:5:"32.71";s:4:"name";s:10:"Kota Bogor";}i:22;a:2:{s:4:"code";s:5:"32.77";s:4:"name";s:11:"Kota Cimahi";}i:23;a:2:{s:4:"code";s:5:"32.74";s:4:"name";s:12:"Kota Cirebon";}i:24;a:2:{s:4:"code";s:5:"32.76";s:4:"name";s:10:"Kota Depok";}i:25;a:2:{s:4:"code";s:5:"32.72";s:4:"name";s:13:"Kota Sukabumi";}i:26;a:2:{s:4:"code";s:5:"32.78";s:4:"name";s:16:"Kota Tasikmalaya";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750385562),
	('regencies_34', 'O:29:"Illuminate\\Support\\Collection":2:{s:8:"\0*\0items";a:5:{i:0;a:2:{s:4:"code";s:5:"34.02";s:4:"name";s:11:"Kab. Bantul";}i:1;a:2:{s:4:"code";s:5:"34.03";s:4:"name";s:16:"Kab. Gunungkidul";}i:2;a:2:{s:4:"code";s:5:"34.01";s:4:"name";s:16:"Kab. Kulon Progo";}i:3;a:2:{s:4:"code";s:5:"34.04";s:4:"name";s:11:"Kab. Sleman";}i:4;a:2:{s:4:"code";s:5:"34.71";s:4:"name";s:15:"Kota Yogyakarta";}}s:28:"\0*\0escapeWhenCastingToString";b:0;}', 1750374752);

-- Dumping structure for table basogilang_apps.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cache_locks: ~0 rows (approximately)

-- Dumping structure for table basogilang_apps.cms_authorization_groups
CREATE TABLE IF NOT EXISTS `cms_authorization_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `userId` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_authorization_groups: ~3 rows (approximately)
INSERT INTO `cms_authorization_groups` (`id`, `name`, `description`, `userId`, `created_at`, `updated_at`) VALUES
	(1, 'Super Admin', 'Full access rights', 1, '2025-04-28 01:17:23', '2025-06-18 05:23:45'),
	(4, 'Staff', 'menu khusus staff', 1, '2025-06-13 07:46:58', '2025-06-13 07:47:41'),
	(5, 'Default', 'Menu Wajib', 1, '2025-06-18 07:06:30', '2025-06-18 07:06:30'),
	(6, 'Owner', 'Fitur Pemilik', 1, '2025-06-18 19:53:46', '2025-06-18 19:59:19');

-- Dumping structure for table basogilang_apps.cms_bahan_baku
CREATE TABLE IF NOT EXISTS `cms_bahan_baku` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` int NOT NULL,
  `satuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga_satuan` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_bahan_baku: ~2 rows (approximately)
INSERT INTO `cms_bahan_baku` (`id`, `created_at`, `updated_at`, `name`, `jumlah`, `satuan`, `harga_satuan`) VALUES
	(2, '2025-05-07 21:40:15', '2025-05-07 21:40:15', 'Tepung Tapioka', 25, 'kg', 16200),
	(3, '2025-05-07 23:18:13', '2025-05-07 23:18:13', 'Ayam', 8, 'kg', 30000),
	(4, '2025-05-19 06:21:03', '2025-05-19 06:21:03', 'Apa aja', 10, 'kg', 1000),
	(5, '2025-06-12 19:19:13', '2025-06-12 19:19:13', 'testing1', 12, 'box', 1000),
	(6, '2025-06-18 06:40:30', '2025-06-18 06:40:30', 'Testing 2 bahan', 10, 'kg', 20000);

-- Dumping structure for table basogilang_apps.cms_bahan_baku_logs
CREATE TABLE IF NOT EXISTS `cms_bahan_baku_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `baku_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inDate` date DEFAULT NULL,
  `outDate` date DEFAULT NULL,
  `jumlah` int NOT NULL,
  `satuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga_satuan` double DEFAULT '0',
  `total_harga` double DEFAULT (0),
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vendor_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `produksi_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_bahan_baku_logs: ~17 rows (approximately)
INSERT INTO `cms_bahan_baku_logs` (`id`, `created_at`, `updated_at`, `baku_id`, `inDate`, `outDate`, `jumlah`, `satuan`, `harga_satuan`, `total_harga`, `category`, `vendor_id`, `produksi_id`) VALUES
	(63, '2025-06-03 21:32:18', '2025-06-03 23:37:08', '2', '2025-06-04', NULL, 60, 'kg', 10000, 600000, 'Restock', '1', NULL),
	(64, '2025-06-03 21:32:32', '2025-06-03 21:32:32', '2', '2025-06-04', NULL, 15, 'kg', 10000, 150000, 'Restock', '1', NULL),
	(72, '2025-06-04 00:54:10', '2025-06-04 00:54:10', '2', NULL, '2025-06-04', 55, 'kg', 0, 0, 'Used', '1', NULL),
	(84, '2025-06-04 02:50:29', '2025-06-04 02:50:29', '2', '2025-06-04', NULL, 30, 'kg', 16000, 480000, 'Restock', '1', NULL),
	(88, '2025-06-04 02:56:39', '2025-06-04 02:56:39', '2', NULL, '2025-06-04', 30, 'kg', 0, 0, 'Used', '1', NULL),
	(89, '2025-06-04 03:12:34', '2025-06-04 03:12:34', '3', '2025-06-04', NULL, 100, 'kg', 40000, 4000000, 'Restock', '3', NULL),
	(96, '2025-06-04 21:32:45', '2025-06-04 21:32:45', '2', NULL, '2025-06-05', 10, 'kg', 0, 0, 'Used', '1', '14'),
	(97, '2025-06-04 21:32:45', '2025-06-04 21:32:45', '3', NULL, '2025-06-05', 40, 'kg', 0, 0, 'Used', '3', '14'),
	(106, '2025-06-04 23:10:43', '2025-06-04 23:10:43', '2', NULL, '2025-06-05', 5, 'kg', 0, 0, 'Used', '1', '19'),
	(107, '2025-06-04 23:10:43', '2025-06-04 23:10:43', '3', NULL, '2025-06-05', 25, 'kg', 0, 0, 'Used', '3', '19'),
	(108, '2025-06-06 21:00:14', '2025-06-06 21:00:14', '2', '2025-06-07', NULL, 50, 'kg', 16000, 800000, 'Restock', '1', NULL),
	(109, '2025-06-06 21:00:35', '2025-06-06 21:00:35', '3', '2025-06-07', NULL, 50, 'kg', 20000, 1000000, 'Restock', '3', NULL),
	(110, '2025-06-06 21:01:03', '2025-06-06 21:01:03', '2', NULL, '2025-06-07', 10, 'kg', 0, 0, 'Used', '1', '20'),
	(111, '2025-06-06 21:01:03', '2025-06-06 21:01:03', '3', NULL, '2025-06-07', 10, 'kg', 0, 0, 'Used', '3', '20'),
	(112, '2025-06-11 07:05:11', '2025-06-11 07:05:11', '3', NULL, '2025-06-11', 70, 'kg', 0, 0, 'Used', '3', NULL),
	(113, '2025-06-11 07:05:52', '2025-06-11 07:05:52', '2', NULL, '2025-06-11', 25, 'kg', 0, 0, 'Used', '1', NULL),
	(114, '2025-06-11 07:07:14', '2025-06-11 07:07:14', '2', '2025-06-11', NULL, 25, 'kg', 8000, 200000, 'Restock', '1', NULL),
	(115, '2025-06-11 07:11:11', '2025-06-11 07:11:11', '2', NULL, '2025-06-11', 10, 'kg', 0, 0, 'Used', '1', NULL),
	(116, '2025-06-11 07:47:14', '2025-06-11 07:47:14', '4', '2025-06-11', NULL, 1, 'kg', 8000, 8000, 'Restock', '3', NULL),
	(117, '2025-06-12 19:19:39', '2025-06-12 19:19:39', '5', '2025-06-13', NULL, 15, 'box', 1000, 15000, 'Restock', '3', NULL),
	(118, '2025-06-12 19:20:11', '2025-06-12 19:20:11', '5', NULL, '2025-06-13', 10, 'box', 0, 0, 'Used', '3', NULL),
	(119, '2025-06-18 06:41:07', '2025-06-18 06:41:07', '6', '2025-06-18', NULL, 100, 'kg', 20000, 2000000, 'Restock', '3', NULL),
	(120, '2025-06-18 06:41:29', '2025-06-18 06:41:29', '6', NULL, '2025-06-18', 10, 'kg', 0, 0, 'Used', '3', NULL),
	(121, '2025-06-18 06:52:04', '2025-06-18 06:52:04', '6', NULL, '2025-06-18', 10, 'kg', 0, 0, 'Used', '3', '121'),
	(122, '2025-06-18 06:52:04', '2025-06-18 06:52:04', '2', NULL, '2025-06-18', 5, 'kg', 0, 0, 'Used', '1', '121'),
	(123, '2025-06-18 08:27:55', '2025-06-18 08:27:55', '6', NULL, '2025-06-18', 10, 'kg', 0, 0, 'Used', '3', NULL);

-- Dumping structure for table basogilang_apps.cms_bahan_baku_stocks
CREATE TABLE IF NOT EXISTS `cms_bahan_baku_stocks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `baku_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` int NOT NULL,
  `restock_log_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_bahan_baku_stocks: ~9 rows (approximately)
INSERT INTO `cms_bahan_baku_stocks` (`id`, `created_at`, `updated_at`, `baku_id`, `logs_id`, `qty`, `restock_log_id`) VALUES
	(20, '2025-06-03 21:32:18', '2025-06-18 06:52:04', '2', '63', 0, 63),
	(21, '2025-06-03 21:32:32', '2025-06-18 06:52:04', '2', '64', 0, 64),
	(23, '2025-06-04 02:50:29', '2025-06-18 06:52:04', '2', '84', 0, 84),
	(24, '2025-06-04 03:12:34', '2025-06-11 07:05:11', '3', '89', 1, 89),
	(25, '2025-06-06 21:00:14', '2025-06-18 06:52:04', '2', '108', 8, 108),
	(26, '2025-06-06 21:00:35', '2025-06-11 07:05:11', '3', '109', 5, 109),
	(27, '2025-06-11 07:07:14', '2025-06-11 07:07:14', '2', '114', 1, 114),
	(28, '2025-06-11 07:47:14', '2025-06-11 07:47:14', '4', '116', 1, 116),
	(29, '2025-06-12 19:19:39', '2025-06-12 19:20:11', '5', '117', 5, 117),
	(30, '2025-06-18 06:41:07', '2025-06-18 08:27:55', '6', '119', 70, 119);

-- Dumping structure for table basogilang_apps.cms_bahan_baku_usages
CREATE TABLE IF NOT EXISTS `cms_bahan_baku_usages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `baku_id` int NOT NULL,
  `restock_log_id` int NOT NULL,
  `used_log_id` int NOT NULL,
  `qty` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_bahan_baku_usages: ~14 rows (approximately)
INSERT INTO `cms_bahan_baku_usages` (`id`, `created_at`, `updated_at`, `baku_id`, `restock_log_id`, `used_log_id`, `qty`) VALUES
	(23, '2025-06-04 00:54:10', '2025-06-04 00:54:10', 2, 63, 72, 55),
	(74, '2025-06-04 02:56:39', '2025-06-04 02:56:39', 2, 63, 88, 5),
	(75, '2025-06-04 02:56:39', '2025-06-04 02:56:39', 2, 64, 88, 15),
	(76, '2025-06-04 02:56:39', '2025-06-04 02:56:39', 2, 84, 88, 10),
	(81, '2025-06-04 21:32:45', '2025-06-04 21:32:45', 2, 84, 96, 10),
	(82, '2025-06-04 21:32:45', '2025-06-04 21:32:45', 3, 89, 97, 40),
	(91, '2025-06-04 23:10:43', '2025-06-04 23:10:43', 2, 84, 106, 5),
	(92, '2025-06-04 23:10:43', '2025-06-04 23:10:43', 3, 89, 107, 25),
	(93, '2025-06-06 21:01:03', '2025-06-06 21:01:03', 2, 84, 110, 5),
	(94, '2025-06-06 21:01:03', '2025-06-06 21:01:03', 2, 108, 110, 5),
	(95, '2025-06-06 21:01:03', '2025-06-06 21:01:03', 3, 89, 111, 10),
	(96, '2025-06-11 07:05:11', '2025-06-11 07:05:11', 3, 89, 112, 25),
	(97, '2025-06-11 07:05:11', '2025-06-11 07:05:11', 3, 109, 112, 45),
	(98, '2025-06-11 07:05:52', '2025-06-11 07:05:52', 2, 108, 113, 25),
	(99, '2025-06-11 07:11:11', '2025-06-11 07:11:11', 2, 108, 115, 10),
	(100, '2025-06-12 19:20:11', '2025-06-12 19:20:11', 5, 117, 118, 10),
	(101, '2025-06-18 06:41:29', '2025-06-18 06:41:29', 6, 119, 120, 10),
	(102, '2025-06-18 06:52:04', '2025-06-18 06:52:04', 6, 119, 121, 10),
	(103, '2025-06-18 06:52:04', '2025-06-18 06:52:04', 2, 63, 122, 1),
	(104, '2025-06-18 06:52:04', '2025-06-18 06:52:04', 2, 64, 122, 1),
	(105, '2025-06-18 06:52:04', '2025-06-18 06:52:04', 2, 84, 122, 1),
	(106, '2025-06-18 06:52:04', '2025-06-18 06:52:04', 2, 108, 122, 2),
	(107, '2025-06-18 08:27:55', '2025-06-18 08:27:55', 6, 119, 123, 10);

-- Dumping structure for table basogilang_apps.cms_bahan_kemasans
CREATE TABLE IF NOT EXISTS `cms_bahan_kemasans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` int NOT NULL,
  `satuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` double NOT NULL,
  `category` int(1) unsigned zerofill DEFAULT NULL COMMENT '0:kemasan, 1:package',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_bahan_kemasans: ~4 rows (approximately)
INSERT INTO `cms_bahan_kemasans` (`id`, `created_at`, `updated_at`, `name`, `jumlah`, `satuan`, `harga`, `category`) VALUES
	(1, '2025-05-10 20:44:14', '2025-05-10 20:44:14', 'BX Jumbo', 50, 'pcs', 88000, 0),
	(2, '2025-05-10 21:13:26', '2025-05-10 21:13:26', 'Plastik PE 10 x 20', 1, 'kg', 36000, 0),
	(3, '2025-06-13 20:20:32', '2025-06-13 20:31:55', 'Kerdus', 10, 'pcs', 1000, 1),
	(4, '2025-06-13 20:25:35', '2025-06-18 06:59:57', 'Mika', 10, 'pcs', 400, 1),
	(5, '2025-06-17 07:42:51', '2025-06-17 07:42:51', 'Tinual', 10, 'pcs', 500, 1),
	(6, '2025-06-18 06:42:57', '2025-06-18 06:42:57', 'Kemasan Testing', 10, 'pcs', 10000, 0),
	(7, '2025-06-18 06:46:55', '2025-06-18 06:46:55', 'Testing 3 Kemasan', 20, 'pcs', 10000, 0),
	(8, '2025-06-18 08:14:35', '2025-06-18 08:14:35', 'test4', 11, 'pcs', 1000, 0),
	(9, '2025-06-18 08:16:20', '2025-06-18 08:16:20', 'test5', 5, 'kg', 1000, 0);

-- Dumping structure for table basogilang_apps.cms_bahan_kemasan_logs
CREATE TABLE IF NOT EXISTS `cms_bahan_kemasan_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `kemasan_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `inDate` date DEFAULT NULL,
  `outDate` date DEFAULT NULL,
  `jumlah` int NOT NULL,
  `satuan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vendor_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_bahan_kemasan_logs: ~10 rows (approximately)
INSERT INTO `cms_bahan_kemasan_logs` (`id`, `created_at`, `updated_at`, `kemasan_id`, `inDate`, `outDate`, `jumlah`, `satuan`, `category`, `vendor_id`, `harga`) VALUES
	(6, '2025-06-04 20:53:42', '2025-06-04 21:12:11', '1', '2025-06-05', NULL, 550, 'pcs', 'Restock', '4', 24000),
	(7, '2025-06-04 21:06:07', '2025-06-04 21:06:07', '1', NULL, '2025-06-05', 100, 'pcs', 'Used', '4', 0),
	(9, '2025-06-13 20:32:45', '2025-06-15 01:19:58', '3', '2025-06-14', NULL, 100, 'pcs', 'Restock', '3', 20000),
	(39, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '3', NULL, '2025-06-17', 2, 'pcs', 'Used', '3', 0),
	(40, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '3', NULL, '2025-06-17', 3, 'pcs', 'Used', '3', 0),
	(41, '2025-06-16 22:50:39', '2025-06-16 22:50:39', '3', NULL, '2025-06-17', 10, 'pcs', 'Used', '3', 0),
	(42, '2025-06-17 07:36:50', '2025-06-17 07:36:50', '3', NULL, '2025-06-17', 5, 'pcs', 'Used', '3', 0),
	(43, '2025-06-17 07:41:55', '2025-06-18 06:58:55', '4', '2025-06-17', NULL, 100, 'pcs', 'Restock', '3', 20000),
	(44, '2025-06-17 07:43:14', '2025-06-18 05:47:55', '5', '2025-06-17', NULL, 50, 'pcs', 'Restock', '3', 25000),
	(47, '2025-06-17 07:45:30', '2025-06-17 07:45:30', '5', NULL, '2025-06-17', 4, 'pcs', 'Used', '3', 0),
	(48, '2025-06-17 07:45:30', '2025-06-17 07:45:30', '4', NULL, '2025-06-17', 2, 'pcs', 'Used', '3', 0),
	(49, '2025-06-18 02:59:24', '2025-06-18 02:59:24', '4', NULL, '2025-06-18', 10, 'pcs', 'Used', '3', 0),
	(50, '2025-06-18 02:59:24', '2025-06-18 02:59:24', '5', NULL, '2025-06-18', 4, 'pcs', 'Used', '3', 0),
	(51, '2025-06-18 03:46:51', '2025-06-18 03:46:51', '4', NULL, '2025-06-18', 4, 'pcs', 'Used', '3', 0),
	(52, '2025-06-18 06:49:04', '2025-06-18 06:49:23', '7', '2025-06-18', NULL, 100, 'pcs', 'Restock', '3', 1000000),
	(53, '2025-06-18 06:49:58', '2025-06-18 06:49:58', '7', NULL, '2025-06-18', 90, 'pcs', 'Used', '3', 0),
	(54, '2025-06-18 07:00:29', '2025-06-18 07:00:29', '4', NULL, '2025-06-18', 1, 'pcs', 'Used', '3', 0);

-- Dumping structure for table basogilang_apps.cms_bahan_kemasan_stocks
CREATE TABLE IF NOT EXISTS `cms_bahan_kemasan_stocks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `kemasan_id` bigint NOT NULL,
  `logs_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` int NOT NULL,
  `restock_log_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_bahan_kemasan_stocks: ~4 rows (approximately)
INSERT INTO `cms_bahan_kemasan_stocks` (`id`, `created_at`, `updated_at`, `kemasan_id`, `logs_id`, `qty`, `restock_log_id`) VALUES
	(1, '2025-06-04 20:53:42', '2025-06-04 21:12:59', 1, '6', 450, '6'),
	(2, '2025-06-13 20:32:45', '2025-06-17 07:36:50', 3, '9', 80, '9'),
	(3, '2025-06-17 07:41:55', '2025-06-18 07:00:29', 4, '43', 83, '43'),
	(4, '2025-06-17 07:43:14', '2025-06-18 02:59:24', 5, '44', 42, '44'),
	(5, '2025-06-18 06:49:04', '2025-06-18 08:30:34', 7, '52', 10, '52');

-- Dumping structure for table basogilang_apps.cms_bahan_kemasan_usages
CREATE TABLE IF NOT EXISTS `cms_bahan_kemasan_usages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `restock_log_id` int NOT NULL,
  `used_log_id` int NOT NULL,
  `qty` int NOT NULL,
  `kemasan_id` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_bahan_kemasan_usages: ~7 rows (approximately)
INSERT INTO `cms_bahan_kemasan_usages` (`id`, `created_at`, `updated_at`, `restock_log_id`, `used_log_id`, `qty`, `kemasan_id`) VALUES
	(1, '2025-06-04 21:06:07', '2025-06-04 21:06:07', 6, 7, 100, 1),
	(32, '2025-06-16 19:33:48', '2025-06-16 19:33:48', 9, 39, 2, 3),
	(33, '2025-06-16 19:33:48', '2025-06-16 19:33:48', 9, 40, 3, 3),
	(34, '2025-06-16 22:50:39', '2025-06-16 22:50:39', 9, 41, 10, 3),
	(35, '2025-06-17 07:36:50', '2025-06-17 07:36:50', 9, 42, 5, 3),
	(38, '2025-06-17 07:45:30', '2025-06-17 07:45:30', 44, 47, 4, 5),
	(39, '2025-06-17 07:45:30', '2025-06-17 07:45:30', 43, 48, 2, 4),
	(40, '2025-06-18 02:59:24', '2025-06-18 02:59:24', 43, 49, 10, 4),
	(41, '2025-06-18 02:59:24', '2025-06-18 02:59:24', 44, 50, 4, 5),
	(42, '2025-06-18 03:46:51', '2025-06-18 03:46:51', 43, 51, 4, 4),
	(43, '2025-06-18 06:49:58', '2025-06-18 06:49:58', 52, 53, 90, 7),
	(44, '2025-06-18 07:00:29', '2025-06-18 07:00:29', 43, 54, 1, 4);

-- Dumping structure for table basogilang_apps.cms_categories
CREATE TABLE IF NOT EXISTS `cms_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `desc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_categories: ~2 rows (approximately)
INSERT INTO `cms_categories` (`id`, `created_at`, `updated_at`, `name`, `desc`, `icon`) VALUES
	(9, '2025-05-05 18:45:28', '2025-05-11 20:22:38', 'Baso Tahu & Siomay', 'Kumpulan semu baso tahun dan siomay', '1747020158-digital-vector-illustration-bakso-meatball-600nw-2313990925.webp'),
	(13, '2025-05-11 20:23:16', '2025-05-11 20:23:16', 'Batagor & Siomay Goreng', 'kumpulan batagor dan siomay Goreng', '1747020196-batagor-baso-goreng-fish-fried-dumpling-vector-removebg-preview.png'),
	(14, '2025-05-19 06:18:04', '2025-05-19 06:18:04', 'Pempek', 'kumpulan pempek', '1747660684-images.jpg'),
	(15, '2025-06-18 06:36:56', '2025-06-18 06:38:10', 'testing', 'asdas', '1750253890-logoVasanta.png'),
	(16, '2025-06-18 06:38:36', '2025-06-18 06:38:36', 'Testing 2', 'test kategori', '1750253916-approved.png');

-- Dumping structure for table basogilang_apps.cms_customers
CREATE TABLE IF NOT EXISTS `cms_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` enum('Konsumen','Distributor') COLLATE utf8mb4_unicode_ci NOT NULL,
  `kab` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kec` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `mark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_patokan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `radius_id` int DEFAULT NULL,
  `prov` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_customers: ~6 rows (approximately)
INSERT INTO `cms_customers` (`id`, `created_at`, `updated_at`, `name`, `telp`, `category`, `kab`, `kec`, `kel`, `address`, `mark`, `image_patokan`, `radius_id`, `prov`) VALUES
	(1, '2025-06-05 10:52:18', '2025-06-06 19:33:06', 'iKRAM', '123123', 'Konsumen', '32.04', '32.04.16', NULL, 'disana pokoknya cari aja sendiri', NULL, NULL, 3, '32'),
	(2, '2025-06-06 07:44:46', '2025-06-06 07:50:06', 'Reselle', '90123101231', 'Konsumen', '32.73', '32.73.21', NULL, 'deket saba', 'deket tikungan', NULL, 2, '32'),
	(3, '2025-06-06 07:47:41', '2025-06-06 07:47:41', 'Supplier', '90123101231', 'Distributor', '32.01', '32.01.05', NULL, 'Sonoan dikit', 'belok kanan setelah tikungan', NULL, 2, '32'),
	(6, '2025-06-13 06:59:26', '2025-06-13 06:59:26', 'Gilang', '123123', 'Distributor', '32.17', '32.17.13', NULL, 'lurus aja terus', 'deket masjid', NULL, 3, '32'),
	(7, '2025-06-17 01:23:01', '2025-06-17 01:23:01', 'Asep Hidayat', '90123101231', 'Konsumen', '31.74', '31.74.06', NULL, 'belakang pohon besar', 'pohon daun ijo', NULL, 3, '31'),
	(8, '2025-06-17 07:39:59', '2025-06-17 07:39:59', 'Uji', '1231231', 'Konsumen', '34.04', '34.04.06', NULL, 'Belakang kampus UTY', 'Burjo', NULL, 2, '34'),
	(9, '2025-06-18 07:01:40', '2025-06-18 07:01:40', 'Rizky', '123123', 'Konsumen', '32.04', '32.04.16', NULL, 'testing cus', 'Testing 123', NULL, 5, '32');

-- Dumping structure for table basogilang_apps.cms_mas_positions
CREATE TABLE IF NOT EXISTS `cms_mas_positions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `mp_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mp_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mp_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_mas_positions: ~5 rows (approximately)
INSERT INTO `cms_mas_positions` (`id`, `mp_code`, `mp_name`, `mp_desc`, `created_at`, `updated_at`) VALUES
	(1, 'MGR', 'Manager', NULL, '2025-04-28 01:10:37', '2025-04-28 01:10:37'),
	(2, 'STF', 'Staff', NULL, '2025-04-28 01:10:37', '2025-04-28 01:10:37'),
	(17, 'SA', 'Admin', NULL, '2025-04-30 05:23:38', NULL),
	(18, 'SP', 'Supplier', 'Penyedia Bahan Baku', '2025-05-01 00:57:18', '2025-05-01 01:11:11'),
	(20, 'OWN', 'Owner', 'pemilik', '2025-06-18 07:10:39', '2025-06-18 07:10:39');

-- Dumping structure for table basogilang_apps.cms_menus
CREATE TABLE IF NOT EXISTS `cms_menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `userId` bigint unsigned NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` enum('Header','Parent','Submenu') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Parent',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_menus_parent_id_foreign` (`parent_id`),
  KEY `cms_menus_userid_foreign` (`userId`),
  CONSTRAINT `cms_menus_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `cms_menus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_menus_userid_foreign` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_menus: ~32 rows (approximately)
INSERT INTO `cms_menus` (`id`, `name`, `url`, `parent_id`, `sort_order`, `userId`, `icon`, `category`, `created_at`, `updated_at`) VALUES
	(20, 'Dasahboard', '/dash', NULL, 1, 1, NULL, 'Header', '2025-04-30 07:06:00', NULL),
	(21, 'Ringkasan', '/dashboard', 20, 1, 1, 'bx-home', 'Parent', '2025-04-30 07:06:51', NULL),
	(22, 'Application Settings', '/setting', NULL, 20, 1, 'bx-cog', 'Header', '2025-04-30 07:07:21', '2025-04-30 05:20:29'),
	(23, 'Menu Management', '/menuManagement', 22, 1, 1, 'bx-menu', 'Parent', '2025-04-30 07:08:01', NULL),
	(24, 'Authorization Group', '/authorizationGroup', 22, 2, 1, 'bx-group', 'Parent', '2025-04-30 07:08:49', NULL),
	(25, 'User Management', '/user-management', 22, 3, 1, 'bx-user', 'Parent', '2025-04-30 07:09:17', NULL),
	(26, 'Laporan-laporan', 'null', 27, 1, 1, 'bx-bar-chart', 'Parent', '2025-04-30 00:48:40', '2025-04-30 05:07:29'),
	(27, 'Laporan', '/report', NULL, 5, 1, 'bx-notepad', 'Header', '2025-04-30 00:57:32', '2025-04-30 23:35:51'),
	(28, 'Laporan Penjualan', '/report', 26, 1, 1, 'bx-line-chart', 'Submenu', '2025-04-30 05:06:25', '2025-06-17 06:51:34'),
	(29, 'Management Item', 'null', NULL, 2, 1, 'bx-purchase-tag', 'Header', '2025-04-30 23:07:58', '2025-04-30 23:35:58'),
	(30, 'Kategori', '/category-management', 29, 1, 1, 'bx-category', 'Parent', '2025-04-30 23:08:49', '2025-05-01 02:49:15'),
	(31, 'Produk', '/items/produk', 29, 2, 1, 'bx-basket', 'Parent', '2025-04-30 23:10:06', '2025-04-30 23:10:06'),
	(32, 'Ongkir', '/items/ongkir', 29, 5, 1, 'bx-dollar-circle', 'Parent', '2025-04-30 23:12:53', '2025-04-30 23:18:26'),
	(33, 'Bahan Kemasan', '/items/bahan-kemasan', 29, 4, 1, 'bx-package', 'Parent', '2025-04-30 23:20:55', '2025-04-30 23:22:04'),
	(34, 'Bahan Baku', '', 29, 3, 1, 'bx-cube', 'Parent', '2025-04-30 23:23:07', '2025-05-07 21:50:36'),
	(35, 'Position Management', '/position-management', 22, 4, 1, 'bx-cog', 'Parent', '2025-05-01 00:28:38', '2025-05-01 00:29:17'),
	(36, 'Vendor Management', '/items/vendor', 29, 4, 1, 'bx-category', 'Parent', '2025-05-07 19:55:09', '2025-05-07 19:55:09'),
	(37, 'Data Bahan Baku', '/items/bahan-baku/list', 34, 1, 1, 'bx-cube', 'Submenu', '2025-05-07 21:48:57', '2025-05-07 21:48:57'),
	(38, 'Restock Bahan Baku', '/items/bahan-baku/restock', 34, 2, 1, 'bx-cube', 'Submenu', '2025-05-07 21:49:39', '2025-05-07 21:49:39'),
	(39, 'Stok Bahan Baku', '/items/bahan-baku/stock', 45, 3, 1, 'bx-cube', 'Parent', '2025-05-08 02:52:26', '2025-05-11 20:41:48'),
	(40, 'Penggunaan Bahan Baku', '/items/bahan-baku/used', 34, 3, 1, 'bx-cube', 'Submenu', '2025-05-08 19:22:24', '2025-06-18 07:22:49'),
	(41, 'Data Bahan kemasan', '/items/bahan-kemasan/list', 33, 1, 1, 'bx-package', 'Submenu', '2025-05-10 20:31:42', '2025-05-10 20:31:42'),
	(42, 'Stok Bahan Kemasan', '/items/bahan-kemasan/stock', 45, 4, 1, 'bx-package', 'Parent', '2025-05-10 20:32:26', '2025-05-11 20:42:02'),
	(43, 'Restock Bahan Kemasan', '/items/bahan-kemasan/restock', 33, 3, 1, 'bx-package', 'Submenu', '2025-05-10 20:32:53', '2025-05-10 20:32:53'),
	(44, 'Penggunaan Kemasan', '/items/bahan-kemasan/used', 33, 4, 1, 'bx-package', 'Submenu', '2025-05-10 20:33:30', '2025-05-10 20:33:30'),
	(45, 'Management Stock', 'null', NULL, 4, 1, 'bx-purchase-tag', 'Header', '2025-05-11 20:36:13', '2025-05-11 20:38:42'),
	(46, 'Produksi', '/produksi', 45, 2, 1, 'bx-cog', 'Parent', '2025-05-11 20:37:49', '2025-05-14 06:19:26'),
	(47, 'Stok Produk', '/stock-product', 45, 1, 1, 'bx-notepad', 'Parent', '2025-05-11 20:40:12', '2025-05-11 20:40:12'),
	(48, 'Stok Packaging', '/packaging', 45, 7, 1, 'bx-package', 'Parent', '2025-06-04 23:26:31', '2025-06-13 20:05:26'),
	(49, 'Management Customer', NULL, NULL, 5, 1, 'bx-user', 'Header', '2025-06-05 02:09:58', '2025-06-05 02:09:58'),
	(50, 'Data Customer', '/data-customer', 49, 1, 1, 'bx-group', 'Parent', '2025-06-05 02:10:38', '2025-06-05 02:10:56'),
	(51, 'Management Transaksi', '/transaction', NULL, 3, 1, 'bx-cart', 'Header', '2025-06-09 00:15:35', '2025-06-11 02:23:28'),
	(52, 'Data Transaksi', '/transaction/data', 51, 1, 1, 'bx-cart', 'Parent', '2025-06-09 00:18:47', '2025-06-09 00:18:47'),
	(53, 'Laporan Pengeluaran', '/report/expenses', 26, 2, 1, 'bx-line-chart', 'Submenu', '2025-06-18 05:23:07', '2025-06-18 05:23:27');

-- Dumping structure for table basogilang_apps.cms_menu_auth_groups
CREATE TABLE IF NOT EXISTS `cms_menu_auth_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint unsigned NOT NULL,
  `menu_id` bigint unsigned NOT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_menu_auth_groups_group_id_foreign` (`group_id`),
  KEY `cms_menu_auth_groups_menu_id_foreign` (`menu_id`),
  CONSTRAINT `cms_menu_auth_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `cms_authorization_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_menu_auth_groups_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `cms_menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=513 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_menu_auth_groups: ~43 rows (approximately)
INSERT INTO `cms_menu_auth_groups` (`id`, `group_id`, `menu_id`, `category`, `created_at`, `updated_at`) VALUES
	(399, 4, 20, NULL, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(400, 4, 21, NULL, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(401, 4, 46, NULL, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(402, 4, 31, NULL, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(403, 4, 47, NULL, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(404, 4, 45, NULL, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(405, 4, 51, NULL, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(406, 4, 52, NULL, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(407, 4, 29, NULL, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(408, 1, 20, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(409, 1, 21, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(410, 1, 22, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(411, 1, 22, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(412, 1, 23, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(413, 1, 24, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(414, 1, 25, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(415, 1, 26, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(416, 1, 27, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(417, 1, 28, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(418, 1, 29, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(419, 1, 30, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(420, 1, 31, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(421, 1, 32, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(422, 1, 33, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(423, 1, 34, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(424, 1, 35, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(425, 1, 36, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(426, 1, 37, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(427, 1, 38, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(428, 1, 39, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(429, 1, 40, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(430, 1, 41, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(431, 1, 42, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(432, 1, 43, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(433, 1, 44, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(434, 1, 45, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(435, 1, 46, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(436, 1, 47, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(437, 1, 48, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(438, 1, 49, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(439, 1, 50, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(440, 1, 51, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(441, 1, 52, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(442, 1, 53, NULL, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(443, 5, 20, NULL, '2025-06-18 07:06:30', '2025-06-18 07:06:30'),
	(444, 5, 21, NULL, '2025-06-18 07:06:30', '2025-06-18 07:06:30'),
	(445, 5, 51, NULL, '2025-06-18 07:06:30', '2025-06-18 07:06:30'),
	(446, 5, 52, NULL, '2025-06-18 07:06:30', '2025-06-18 07:06:30'),
	(480, 6, 20, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(481, 6, 21, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(482, 6, 22, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(483, 6, 24, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(484, 6, 25, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(485, 6, 26, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(486, 6, 27, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(487, 6, 28, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(488, 6, 29, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(489, 6, 30, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(490, 6, 31, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(491, 6, 32, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(492, 6, 33, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(493, 6, 34, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(494, 6, 35, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(495, 6, 36, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(496, 6, 37, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(497, 6, 38, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(498, 6, 39, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(499, 6, 40, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(500, 6, 41, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(501, 6, 42, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(502, 6, 43, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(503, 6, 44, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(504, 6, 45, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(505, 6, 46, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(506, 6, 47, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(507, 6, 48, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(508, 6, 49, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(509, 6, 50, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(510, 6, 51, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(511, 6, 52, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19'),
	(512, 6, 53, NULL, '2025-06-18 19:59:19', '2025-06-18 19:59:19');

-- Dumping structure for table basogilang_apps.cms_ongkirs
CREATE TABLE IF NOT EXISTS `cms_ongkirs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `radius` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `desc` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_ongkirs: ~2 rows (approximately)
INSERT INTO `cms_ongkirs` (`id`, `created_at`, `updated_at`, `radius`, `price`, `desc`) VALUES
	(2, '2025-06-05 00:59:03', '2025-06-05 01:05:45', '1 - 3 Km', 0, '1 sampai 3 kilometer'),
	(3, '2025-06-05 01:00:40', '2025-06-05 01:06:57', '> 3 Km - 5 Km', 5000, 'lebih dari 3 kilo meter sampai 5 kilometer'),
	(5, '2025-06-18 06:50:59', '2025-06-18 06:50:59', '5 -10 KM', 10000, 'kena ongkir nantinya');

-- Dumping structure for table basogilang_apps.cms_packages
CREATE TABLE IF NOT EXISTS `cms_packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `desc` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_packages: ~2 rows (approximately)
INSERT INTO `cms_packages` (`id`, `created_at`, `updated_at`, `name`, `price`, `desc`) VALUES
	(1, '2025-06-05 00:04:03', '2025-06-05 00:04:03', 'Kerdus', 2000, 'packaging kerdus'),
	(2, '2025-06-05 00:06:16', '2025-06-05 00:06:16', 'MIka', 500, 'Packaging Mika plastik');

-- Dumping structure for table basogilang_apps.cms_products
CREATE TABLE IF NOT EXISTS `cms_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double NOT NULL DEFAULT '0',
  `satuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_products: ~3 rows (approximately)
INSERT INTO `cms_products` (`id`, `created_at`, `updated_at`, `code`, `name`, `desc`, `image`, `category_id`, `price`, `satuan`) VALUES
	(5, '2025-05-11 20:24:29', '2025-05-17 00:46:41', 'BTY', 'Baso Tahu Yun-Yi', 'Bakso tahu tun yi', '1747020269-digital-vector-illustration-bakso-meatball-600nw-2313990925.webp', '9', 7500, 'pcs'),
	(6, '2025-05-11 20:29:30', '2025-05-17 00:46:47', 'BTGY', 'Batagor Yun-Yi', 'Batagor Yun Yi', '1747020570-batagor-baso-goreng-fish-fried-dumpling-vector-removebg-preview.png', '13', 7500, 'pcs'),
	(7, '2025-05-17 00:46:32', '2025-05-17 00:46:32', 'SGS', 'Siomay Goreng Spesial', 'Siomay pokoknya, makan aja', '1747467992-siomay.jpg', '13', 3000, 'pcs'),
	(8, '2025-05-19 06:20:18', '2025-05-19 06:20:18', 'KPM', 'Kuah Pempek', 'kuah pempek', '1747660818-siomay.jpg', '14', 3000, 'liter'),
	(9, '2025-06-18 06:39:28', '2025-06-18 06:39:48', 'PM', 'Pempek 1', 'asdasdas', '1750253968-approved.png', '14', 10000, 'pcs');

-- Dumping structure for table basogilang_apps.cms_stocks
CREATE TABLE IF NOT EXISTS `cms_stocks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` int NOT NULL,
  `log_id` int DEFAULT NULL,
  `qty_frozen` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_stocks: ~4 rows (approximately)
INSERT INTO `cms_stocks` (`id`, `created_at`, `updated_at`, `product_id`, `qty`, `log_id`, `qty_frozen`) VALUES
	(28, '2025-06-15 07:07:56', '2025-06-18 03:46:51', '5', 0, 63, 3),
	(29, '2025-06-15 07:08:11', '2025-06-18 02:59:24', '6', 7, 64, 15),
	(30, '2025-06-16 16:14:05', '2025-06-18 02:59:24', '5', 125, 67, 0),
	(31, '2025-06-16 16:14:23', '2025-06-16 19:33:48', '7', 126, 68, 0),
	(32, '2025-06-18 06:52:04', '2025-06-18 06:52:46', '9', 60, 121, 40);

-- Dumping structure for table basogilang_apps.cms_stock_logs
CREATE TABLE IF NOT EXISTS `cms_stock_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` int NOT NULL,
  `satuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_harga` double NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trans_id` bigint DEFAULT NULL,
  `stock_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_stock_logs: ~43 rows (approximately)
INSERT INTO `cms_stock_logs` (`id`, `created_at`, `updated_at`, `product_id`, `qty`, `satuan`, `total_harga`, `category`, `trans_id`, `stock_id`) VALUES
	(63, '2025-06-15 07:07:56', '2025-06-15 07:07:56', '5', 100, 'pcs', 750000, '1', NULL, NULL),
	(64, '2025-06-15 07:08:11', '2025-06-15 07:08:11', '6', 50, 'pcs', 375000, '1', NULL, NULL),
	(65, '2025-06-15 07:14:01', '2025-06-15 07:14:01', '5', -20, 'pcs', 0, '0', 12, 28),
	(66, '2025-06-15 07:14:01', '2025-06-15 07:14:01', '6', -1, 'pcs', 0, '0', 13, 29),
	(67, '2025-06-16 16:14:05', '2025-06-16 16:14:05', '5', 200, 'pcs', 1500000, '1', NULL, NULL),
	(68, '2025-06-16 16:14:23', '2025-06-16 16:14:23', '7', 150, 'pcs', 450000, '1', NULL, NULL),
	(69, '2025-06-16 16:32:42', '2025-06-16 16:32:42', '6', -5, 'pcs', 0, '0', 15, 29),
	(70, '2025-06-16 17:08:05', '2025-06-16 17:08:05', '6', -3, 'pcs', 0, '0', 22, 29),
	(71, '2025-06-16 17:19:03', '2025-06-16 17:19:03', '6', 5, 'pcs', 0, '0', 15, 29),
	(72, '2025-06-16 17:20:17', '2025-06-16 17:20:17', '6', 3, 'pcs', 0, '0', 22, 29),
	(73, '2025-06-16 19:01:47', '2025-06-16 19:01:47', '5', -14, 'pcs', 0, '0', 23, 28),
	(74, '2025-06-16 19:02:43', '2025-06-16 19:02:43', '5', 14, 'pcs', 0, '0', 23, 28),
	(75, '2025-06-16 19:03:44', '2025-06-16 19:03:44', '5', 20, 'pcs', 0, '0', 12, 28),
	(76, '2025-06-16 19:03:44', '2025-06-16 19:03:44', '6', 1, 'pcs', 0, '0', 13, 29),
	(77, '2025-06-16 19:05:47', '2025-06-16 19:05:47', '6', -10, 'pcs', 0, '0', 26, 29),
	(78, '2025-06-16 19:07:16', '2025-06-16 19:07:16', '6', 10, 'pcs', 0, '0', 26, 29),
	(84, '2025-06-16 19:08:17', '2025-06-16 19:08:17', '5', -40, 'pcs', 0, '0', 31, 28),
	(85, '2025-06-16 19:08:17', '2025-06-16 19:08:17', '6', -20, 'pcs', 0, '0', 32, 29),
	(86, '2025-06-16 19:08:17', '2025-06-16 19:08:17', '6', -10, 'pcs', 0, '0', 33, 29),
	(87, '2025-06-16 19:09:43', '2025-06-16 19:09:43', '5', 40, 'pcs', 0, '0', 31, 28),
	(88, '2025-06-16 19:09:43', '2025-06-16 19:09:43', '6', 20, 'pcs', 0, '0', 32, 29),
	(89, '2025-06-16 19:09:43', '2025-06-16 19:09:43', '6', 10, 'pcs', 0, '0', 33, 29),
	(90, '2025-06-16 19:11:53', '2025-06-16 19:11:53', '7', -5, 'pcs', 0, '0', 34, 31),
	(91, '2025-06-16 19:11:53', '2025-06-16 19:11:53', '6', -10, 'pcs', 0, '0', 35, 29),
	(92, '2025-06-16 19:16:54', '2025-06-16 19:16:54', '7', 5, 'pcs', 0, '0', 34, 31),
	(93, '2025-06-16 19:16:54', '2025-06-16 19:16:54', '6', 10, 'pcs', 0, '0', 35, 29),
	(96, '2025-06-16 19:18:39', '2025-06-16 19:18:39', '7', -8, 'pcs', 0, '0', 38, 31),
	(97, '2025-06-16 19:18:39', '2025-06-16 19:18:39', '6', -9, 'pcs', 0, '0', 39, 29),
	(98, '2025-06-16 19:19:14', '2025-06-16 19:19:14', '7', 8, 'pcs', 0, '0', 38, 31),
	(99, '2025-06-16 19:19:14', '2025-06-16 19:19:14', '6', 9, 'pcs', 0, '0', 39, 29),
	(100, '2025-06-16 19:21:52', '2025-06-16 19:21:52', '6', -8, 'pcs', 0, '0', 40, 29),
	(101, '2025-06-16 19:21:52', '2025-06-16 19:21:52', '7', -6, 'pcs', 0, '0', 41, 31),
	(102, '2025-06-16 19:29:42', '2025-06-16 19:29:42', '6', 8, 'pcs', 0, '0', 40, 29),
	(103, '2025-06-16 19:29:42', '2025-06-16 19:29:42', '7', 6, 'pcs', 0, '0', 41, 31),
	(104, '2025-06-16 19:29:42', '2025-06-16 19:29:42', '6', -8, 'pcs', 0, '0', 42, 29),
	(105, '2025-06-16 19:29:42', '2025-06-16 19:29:42', '7', -6, 'pcs', 0, '0', 43, 31),
	(106, '2025-06-16 19:29:42', '2025-06-16 19:29:42', '7', -18, 'pcs', 0, '0', 44, 31),
	(107, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '6', 8, 'pcs', 0, '0', 42, 29),
	(108, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '7', 6, 'pcs', 0, '0', 43, 31),
	(109, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '7', 18, 'pcs', 0, '0', 44, 31),
	(110, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '6', -8, 'pcs', 0, '0', 45, 29),
	(111, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '7', -6, 'pcs', 0, '0', 46, 31),
	(112, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '7', -18, 'pcs', 0, '0', 47, 31),
	(113, '2025-06-16 22:50:39', '2025-06-16 22:50:39', '5', -75, 'pcs', 0, '0', 48, 28),
	(114, '2025-06-16 22:50:39', '2025-06-16 22:50:39', '5', -25, 'pcs', 0, '0', 48, 30),
	(115, '2025-06-17 07:45:13', '2025-06-17 07:45:13', '5', -10, 'pcs', 0, '0', 51, 28),
	(116, '2025-06-17 07:45:30', '2025-06-17 07:45:30', '5', 10, 'pcs', 0, '0', 51, 28),
	(117, '2025-06-17 07:45:30', '2025-06-17 07:45:30', '5', -10, 'pcs', 0, '0', 53, 28),
	(118, '2025-06-18 02:59:24', '2025-06-18 02:59:24', '5', -50, 'pcs', 0, '0', 54, 30),
	(119, '2025-06-18 02:59:24', '2025-06-18 02:59:24', '6', -20, 'pcs', 0, '0', 55, 29),
	(120, '2025-06-18 03:46:51', '2025-06-18 03:46:51', '5', -12, 'pcs', 0, '0', 56, 28),
	(121, '2025-06-18 06:52:04', '2025-06-18 06:52:04', '9', 100, 'pcs', 1000000, '1', NULL, NULL);

-- Dumping structure for table basogilang_apps.cms_transactions
CREATE TABLE IF NOT EXISTS `cms_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `qty` int NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_price` double NOT NULL,
  `customer_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_date` date DEFAULT NULL,
  `delivery_time` time DEFAULT NULL,
  `delivery_status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pack_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Unpack',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_transactions: ~7 rows (approximately)
INSERT INTO `cms_transactions` (`id`, `created_at`, `updated_at`, `qty`, `status`, `total_price`, `customer_id`, `delivery_date`, `delivery_time`, `delivery_status`, `pack_status`) VALUES
	(27, '2025-06-16 19:33:48', '2025-06-16 19:33:48', 32, 'Paid', 137000, '2', '2025-06-17', '09:33:00', 'Deliver', 'Pack'),
	(28, '2025-06-16 22:50:39', '2025-06-16 22:50:39', 100, 'Paid', 765000, '6', '2025-06-17', '12:50:00', 'Pending', 'Pack'),
	(30, '2025-06-16 07:36:50', '2025-06-16 07:36:50', 25, 'Paid', 192500, '2', NULL, NULL, 'Pending', 'Unpack'),
	(32, '2025-05-17 07:45:30', '2025-05-17 07:45:30', 30, 'Paid', 228000, '8', NULL, NULL, 'Pending', 'Unpack'),
	(33, '2025-06-18 02:59:24', '2025-06-18 02:59:24', 70, 'Paid', 537000, '7', '2025-06-18', '16:58:00', 'Deliver', 'Pack'),
	(34, '2025-05-24 03:46:51', '2025-05-24 03:46:51', 12, 'Paid', 92000, '2', '2025-05-17', '17:17:26', 'Deliver', 'Pack'),
	(35, '2025-06-18 07:00:29', '2025-06-18 07:00:29', 5, 'Paid', 55400, '7', NULL, NULL, 'Pending', 'Unpack');

-- Dumping structure for table basogilang_apps.cms_transaction_details
CREATE TABLE IF NOT EXISTS `cms_transaction_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `trans_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_price` double NOT NULL,
  `qty` int NOT NULL,
  `product_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_pack` int DEFAULT NULL,
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_package_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_transaction_details: ~6 rows (approximately)
INSERT INTO `cms_transaction_details` (`id`, `created_at`, `updated_at`, `trans_id`, `unit_price`, `total_price`, `qty`, `product_id`, `jumlah_pack`, `category`, `transaction_package_id`) VALUES
	(45, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '27', '7500', 30000, 4, '6', 2, 'Fresh', 36),
	(46, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '27', '3000', 9000, 3, '7', 2, 'Fresh', 36),
	(47, '2025-06-16 19:33:48', '2025-06-16 19:33:48', '27', '3000', 18000, 6, '7', 3, 'Fresh', 37),
	(48, '2025-06-16 22:50:39', '2025-06-16 22:50:39', '28', '7500', 75000, 10, '5', 10, 'Fresh', 38),
	(49, '2025-06-16 07:36:50', '2025-06-16 07:36:50', '30', '7500', 37500, 5, '5', 5, 'Fresh', 39),
	(52, '2025-05-17 07:45:30', '2025-05-17 07:45:30', '32', '7500', 37500, 5, '6', 4, 'Fresh', 42),
	(53, '2025-05-17 07:45:30', '2025-05-17 07:45:30', '32', '7500', 37500, 5, '5', 2, 'Frozen', 43),
	(54, '2025-06-18 02:59:24', '2025-06-18 02:59:24', '33', '7500', 37500, 5, '5', 10, 'Fresh', 44),
	(55, '2025-06-18 02:59:24', '2025-06-18 02:59:24', '33', '7500', 37500, 5, '6', 5, 'Fresh', 45),
	(56, '2025-06-18 03:46:51', '2025-06-18 03:46:51', '34', '7500', 22500, 3, '5', 4, 'Frozen', 46),
	(57, '2025-06-18 07:00:29', '2025-06-18 07:00:29', '35', '10000', 50000, 5, '9', 1, 'Fresh', 47);

-- Dumping structure for table basogilang_apps.cms_transaction_packages
CREATE TABLE IF NOT EXISTS `cms_transaction_packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int NOT NULL,
  `packaging` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_pack` int NOT NULL,
  `total_price` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_transaction_packages: ~6 rows (approximately)
INSERT INTO `cms_transaction_packages` (`id`, `transaction_id`, `packaging`, `jumlah_pack`, `total_price`, `created_at`, `updated_at`) VALUES
	(36, 27, '3', 2, 80000, '2025-06-16 19:33:48', '2025-06-16 19:33:48'),
	(37, 27, '3', 3, 57000, '2025-06-16 19:33:48', '2025-06-16 19:33:48'),
	(38, 28, '3', 10, 760000, '2025-06-16 22:50:39', '2025-06-16 22:50:39'),
	(39, 30, '3', 5, 192500, '2025-06-17 07:36:50', '2025-06-17 07:36:50'),
	(42, 32, '5', 4, 152000, '2025-06-17 07:45:30', '2025-06-17 07:45:30'),
	(43, 32, '4', 2, 76000, '2025-06-17 07:45:30', '2025-06-17 07:45:30'),
	(44, 33, '4', 10, 380000, '2025-06-18 02:59:24', '2025-06-18 02:59:24'),
	(45, 33, '5', 4, 152000, '2025-06-18 02:59:24', '2025-06-18 02:59:24'),
	(46, 34, '4', 4, 92000, '2025-06-18 03:46:51', '2025-06-18 03:46:51'),
	(47, 35, '4', 1, 50400, '2025-06-18 07:00:29', '2025-06-18 07:00:29');

-- Dumping structure for table basogilang_apps.cms_user_auth_groups
CREATE TABLE IF NOT EXISTS `cms_user_auth_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_user_auth_groups_group_id_foreign` (`group_id`),
  KEY `cms_user_auth_groups_user_id_foreign` (`user_id`),
  CONSTRAINT `cms_user_auth_groups_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `cms_authorization_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_user_auth_groups_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_user_auth_groups: ~3 rows (approximately)
INSERT INTO `cms_user_auth_groups` (`id`, `group_id`, `user_id`, `created_at`, `updated_at`) VALUES
	(31, 4, 7, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(32, 4, 1, '2025-06-13 07:47:41', '2025-06-13 07:47:41'),
	(33, 1, 1, '2025-06-18 05:23:45', '2025-06-18 05:23:45'),
	(35, 5, 7, '2025-06-18 07:06:30', '2025-06-18 07:06:30'),
	(36, 5, 9, '2025-06-18 07:07:13', '2025-06-18 07:07:13'),
	(38, 5, 11, '2025-06-18 19:58:17', '2025-06-18 19:58:17'),
	(39, 6, 11, '2025-06-18 19:59:19', '2025-06-18 19:59:19');

-- Dumping structure for table basogilang_apps.cms_vendors
CREATE TABLE IF NOT EXISTS `cms_vendors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `desc` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.cms_vendors: ~4 rows (approximately)
INSERT INTO `cms_vendors` (`id`, `created_at`, `updated_at`, `name`, `desc`) VALUES
	(1, '2025-05-07 20:19:01', '2025-05-07 20:29:49', 'Gunung Agung', 'Merk Tepung'),
	(3, '2025-05-08 00:31:27', '2025-05-08 00:31:27', 'Pasar', 'Pasar terdekat'),
	(4, '2025-05-10 20:44:59', '2025-05-10 20:44:59', 'Jumbo', 'BX kemasan'),
	(5, '2025-05-10 21:13:57', '2025-05-10 21:13:57', 'PE', 'plastik PE');

-- Dumping structure for table basogilang_apps.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table basogilang_apps.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.jobs: ~0 rows (approximately)

-- Dumping structure for table basogilang_apps.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.job_batches: ~0 rows (approximately)

-- Dumping structure for table basogilang_apps.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.migrations: ~32 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2025_04_28_075504_create_cms_users_table', 2),
	(5, '2025_04_28_075735_create_cms_mas_positions_table', 2),
	(6, '2025_04_28_075823_create_cms_menus_table', 2),
	(7, '2025_04_28_075852_create_cms_user_auth_groups_table', 2),
	(8, '2025_04_28_075903_create_cms_menu_auth_groups_table', 2),
	(9, '2025_04_28_081829_create_sessions_table', 3),
	(10, '2025_04_28_082053_create_personal_access_tokens_table', 3),
	(11, '2025_05_01_092236_create_cms_categories_table', 4),
	(12, '2025_05_06_020033_create_cms_products_table', 5),
	(13, '2025_05_07_084329_create_cms_customers_table', 6),
	(14, '2025_05_07_091613_create_cms_vendors_table', 6),
	(15, '2025_05_07_091832_create_cms_bahan_baku_table', 6),
	(16, '2025_05_07_101429_create_cms_bahan_kemasans_table', 6),
	(17, '2025_05_07_103008_create_cms_bahan_baku_logs_table', 7),
	(18, '2025_05_07_104307_create_cms_bahan_baku_stocks_table', 7),
	(19, '2025_05_11_030338_drop_cms_bahan_baku_stocks_table', 8),
	(20, '2025_05_11_030552_create_cms_bahan_kemasan_logs_table', 8),
	(21, '2025_05_11_035321_update_cms_bahan_kemasan_logs_table', 9),
	(26, '2025_05_12_034618_create_cms_stocks_table', 10),
	(27, '2025_05_12_034634_create_cms_stock_logs_table', 10),
	(28, '2025_05_17_082624_update_cms_bahan_baku_logs_table', 10),
	(30, '2025_06_01_144149_create_cms_bahan_baku_usages_table', 11),
	(31, '2025_06_05_030549_create_cms_bahan_kemasan_stocks_table', 12),
	(32, '2025_06_05_030602_create_cms_bahan_kemasan_usages_table', 12),
	(33, '2025_06_05_032149_update_cms_bahan_kemasan_usages_table', 13),
	(34, '2025_06_05_035232_update_cms_bahan_kemasan_stocks_table', 14),
	(35, '2025_06_05_063532_create_cms_packages_table', 15),
	(36, '2025_06_05_073315_create_cms_ongkirs_table', 16),
	(39, '2025_06_09_051557_create_cms_transactions_table', 17),
	(40, '2025_06_09_065435_create_cms_transaction_details_table', 17),
	(41, '2025_06_15_105449_create_transaction_packages_table', 18);

-- Dumping structure for table basogilang_apps.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.personal_access_tokens: ~53 rows (approximately)
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
	(1, 'App\\Models\\User', 1, 'auth_token', '1f21523bfc4f27d3d134a1bddc8033b0bd1a198171110b4b2e93169d3e1e4d3d', '["*"]', NULL, NULL, '2025-04-28 01:24:13', '2025-04-28 01:24:13'),
	(2, 'App\\Models\\User', 1, 'auth_token', 'e014b742babad235b5fff38cd117908a36d7385fe05e9e04f56df5c2ce908fa9', '["*"]', NULL, NULL, '2025-04-29 21:36:55', '2025-04-29 21:36:55'),
	(3, 'App\\Models\\User', 1, 'auth_token', 'ce7e6f660e94b446855df42ec44ddd3d28870a32ded2d89377123ae6a172db30', '["*"]', NULL, NULL, '2025-04-29 21:46:57', '2025-04-29 21:46:57'),
	(4, 'App\\Models\\User', 1, 'auth_token', 'd26bbfdc2def8057d9ac3afd30ca4ca9b14e2133114828fb9ae70fa551264f20', '["*"]', NULL, NULL, '2025-04-29 21:48:51', '2025-04-29 21:48:51'),
	(5, 'App\\Models\\User', 1, 'auth_token', '34395f48313f1779832b48c7a749fd8bec7cbe7c9bb2ff570714b465916ac5e2', '["*"]', NULL, NULL, '2025-04-29 22:06:37', '2025-04-29 22:06:37'),
	(6, 'App\\Models\\User', 1, 'auth_token', 'caec60af081cceebca63d42e607a43ef17e616f4bbb128929410411243ca00fa', '["*"]', NULL, NULL, '2025-04-29 22:07:57', '2025-04-29 22:07:57'),
	(7, 'App\\Models\\User', 1, 'auth_token', '340bae252c86782a1d6c1cb3f6a7955b39de16946ab6842aac0336d53f0abb9e', '["*"]', NULL, NULL, '2025-04-29 22:08:53', '2025-04-29 22:08:53'),
	(8, 'App\\Models\\User', 1, 'auth_token', 'c6be4cf4f52f9c0686317c4fd4003a6a97e72642078eec34b8fc97bdc1915841', '["*"]', NULL, NULL, '2025-04-29 22:12:43', '2025-04-29 22:12:43'),
	(9, 'App\\Models\\User', 1, 'auth_token', 'd05608c7d98515603ad2933ae3b64c9bf39abca09680c7fb9a98392f6aac941d', '["*"]', NULL, NULL, '2025-04-29 22:13:15', '2025-04-29 22:13:15'),
	(10, 'App\\Models\\User', 1, 'auth_token', 'f0b44bd482594e6183820596707ccf7ac3d3a619c00ba46f692419c41066583f', '["*"]', NULL, NULL, '2025-04-29 22:25:44', '2025-04-29 22:25:44'),
	(11, 'App\\Models\\User', 1, 'auth_token', 'aef68598f5ba8d443280d04930fcde3ea47335825edb84d6e0a4a2c40c7453b7', '["*"]', NULL, NULL, '2025-04-30 00:11:33', '2025-04-30 00:11:33'),
	(12, 'App\\Models\\User', 1, 'auth_token', '04618d4095e8cd97f0d2987e44e97cf730c5f9dc40ee1ce1125b2e8809d42826', '["*"]', NULL, NULL, '2025-04-30 00:19:17', '2025-04-30 00:19:17'),
	(13, 'App\\Models\\User', 1, 'auth_token', 'f890af999fff35b2721a3b7dc6644d151d399d2465f026c070d5f4babfd33d22', '["*"]', NULL, NULL, '2025-04-30 00:20:51', '2025-04-30 00:20:51'),
	(14, 'App\\Models\\User', 1, 'auth_token', 'ea644a75575b037ea097c0f71ec04f6a47f03305ba6581789d0163ae8730a921', '["*"]', NULL, NULL, '2025-04-30 00:55:43', '2025-04-30 00:55:43'),
	(15, 'App\\Models\\User', 1, 'auth_token', 'ea9e9c61ac6875e63290700053d5c31fe5749804ddc2573f20e8e85ad6238e0d', '["*"]', NULL, NULL, '2025-04-30 01:04:47', '2025-04-30 01:04:47'),
	(16, 'App\\Models\\User', 1, 'auth_token', 'b9ad74a1c350d420fd7e5475681ff49a2b698f52d88e54421edfd61fa648d4f7', '["*"]', NULL, NULL, '2025-04-30 01:07:20', '2025-04-30 01:07:20'),
	(17, 'App\\Models\\User', 1, 'auth_token', '7c18d43eb0b0d5f8b683e2c0c50e9314e956fc547cf15251f9fbdaf358c67536', '["*"]', NULL, NULL, '2025-04-30 04:54:10', '2025-04-30 04:54:10'),
	(18, 'App\\Models\\User', 1, 'auth_token', 'a0631773cd01481471491b0d398f681ad0cb8d3d8649f96918ed530ec858b3b4', '["*"]', NULL, NULL, '2025-04-30 05:01:54', '2025-04-30 05:01:54'),
	(19, 'App\\Models\\User', 1, 'auth_token', '222aa0869393ce1e3aca85ed0e234bf974f9801bcc34b9724d4dfc34afa676e7', '["*"]', NULL, NULL, '2025-04-30 05:03:49', '2025-04-30 05:03:49'),
	(20, 'App\\Models\\User', 1, 'auth_token', '13802aa0decb286f3d204d554321fdca65d6aa22a2ccc5c336e6a780786307d6', '["*"]', NULL, NULL, '2025-04-30 05:21:06', '2025-04-30 05:21:06'),
	(21, 'App\\Models\\User', 1, 'auth_token', '9ccd7dab65b1e390207980d9d06b22f898a645725ac8bd87befcef5cf3f29b67', '["*"]', NULL, NULL, '2025-04-30 06:49:41', '2025-04-30 06:49:41'),
	(22, 'App\\Models\\User', 6, 'auth_token', 'ed1dc3aa45cb0ce5ff99fcf13042aa35132ae89f62bfadbae4378e2a8be7fdab', '["*"]', NULL, NULL, '2025-04-30 23:47:16', '2025-04-30 23:47:16'),
	(23, 'App\\Models\\User', 1, 'auth_token', '795f714eeaefb6e1545b92c83d0a4a45af1ca9cd6ab7fd7a029a662ae58958f5', '["*"]', NULL, NULL, '2025-04-30 23:48:20', '2025-04-30 23:48:20'),
	(24, 'App\\Models\\User', 1, 'auth_token', '430de9874807038a088cda1e31b38cf415245cb74e866fccb8ef3347258ebc5c', '["*"]', NULL, NULL, '2025-05-01 01:54:14', '2025-05-01 01:54:14'),
	(25, 'App\\Models\\User', 1, 'auth_token', 'c4d8bcc943a389f78044dabaafe1b0a092b859098538b3d5db50835c964cef48', '["*"]', NULL, NULL, '2025-05-04 05:44:49', '2025-05-04 05:44:49'),
	(26, 'App\\Models\\User', 1, 'auth_token', 'f894a63c0c75ca55419c99d49c3d9392fe7e25aee138e6398e89efae25446416', '["*"]', NULL, NULL, '2025-05-05 06:22:48', '2025-05-05 06:22:48'),
	(27, 'App\\Models\\User', 1, 'auth_token', 'f63bd0729b3ae5dc5de005b0faa2853e82146c9f99f1fe833a1ec5feb6d309a4', '["*"]', NULL, NULL, '2025-05-07 21:51:08', '2025-05-07 21:51:08'),
	(28, 'App\\Models\\User', 1, 'auth_token', '48fa503ae9a9d90e6a7b92ae1863e636706fdcbfc001e8d396f2a061093f341e', '["*"]', NULL, NULL, '2025-05-07 21:53:47', '2025-05-07 21:53:47'),
	(29, 'App\\Models\\User', 1, 'auth_token', '619e4aaa94af4048001f426247b8abf83b9808e177e5f02bc3dee90f2b9d1344', '["*"]', NULL, NULL, '2025-05-07 22:59:14', '2025-05-07 22:59:14'),
	(30, 'App\\Models\\User', 1, 'auth_token', '800c377198700809e576728300d7468d52ea435cfc724fd6152680bacfdf0cb1', '["*"]', NULL, NULL, '2025-05-07 23:07:38', '2025-05-07 23:07:38'),
	(31, 'App\\Models\\User', 1, 'auth_token', 'd228941fa6e5c2d4c0978ba7e40240345950de6a4c9b4adde81518711db1bc5e', '["*"]', NULL, NULL, '2025-05-08 01:36:59', '2025-05-08 01:36:59'),
	(32, 'App\\Models\\User', 1, 'auth_token', '597e885c887df64966a9d0078f5f8748a066bba275b78cfe4cdccaf4fec3d648', '["*"]', NULL, NULL, '2025-05-08 19:13:33', '2025-05-08 19:13:33'),
	(33, 'App\\Models\\User', 1, 'auth_token', 'bdeaab9701432c654703e088ad4279b744ad0855f0a79facc4b8745a083bbaa7', '["*"]', NULL, NULL, '2025-05-10 19:55:56', '2025-05-10 19:55:56'),
	(34, 'App\\Models\\User', 1, 'auth_token', 'f5b014e006337105776070b418762ed5472bc853563a5dccdb4eaac12d255904', '["*"]', NULL, NULL, '2025-05-11 20:06:43', '2025-05-11 20:06:43'),
	(35, 'App\\Models\\User', 1, 'auth_token', '2269949d58c63eea4fef0bade09728a4939267ff9115133ef29ef954db53849e', '["*"]', NULL, NULL, '2025-05-11 21:58:33', '2025-05-11 21:58:33'),
	(36, 'App\\Models\\User', 1, 'auth_token', '657f3d970e9b785a18c84b355a5372878904cd9b3f7ab7d0f1e0e7c953a992ba', '["*"]', NULL, NULL, '2025-05-12 20:08:03', '2025-05-12 20:08:03'),
	(37, 'App\\Models\\User', 1, 'auth_token', '184f0e369bdebfa61e7bf2a5ef0155d4440a02b3ef78a2ef58dbb0499ae5d737', '["*"]', NULL, NULL, '2025-05-13 04:11:11', '2025-05-13 04:11:11'),
	(38, 'App\\Models\\User', 1, 'auth_token', '1e45e64ce018bc6457491db075725d26858c5ae88b564623c766e1f9bd3af0cd', '["*"]', NULL, NULL, '2025-05-17 02:40:36', '2025-05-17 02:40:36'),
	(39, 'App\\Models\\User', 1, 'auth_token', '7f635524ae40d2fe5d3510a473af0525762dd0b9aeb7b11189df037de383056f', '["*"]', NULL, NULL, '2025-05-17 03:33:23', '2025-05-17 03:33:23'),
	(40, 'App\\Models\\User', 1, 'auth_token', 'a526c68aa13eeaf9d3d19e6284ee6983cbd6e57733128bae50b4699acc08afd7', '["*"]', NULL, NULL, '2025-05-18 06:37:41', '2025-05-18 06:37:41'),
	(41, 'App\\Models\\User', 1, 'auth_token', 'e99591cc0ca59b17f0bcb45d35c5e439d49fbee0c3ac6a2671a1b2a6b7628cbb', '["*"]', NULL, NULL, '2025-05-19 05:53:26', '2025-05-19 05:53:26'),
	(42, 'App\\Models\\User', 1, 'auth_token', '2ae90aa3783240b9d1e6a1292f6348fb44a0e53ee4efa5e4799c48b9c2176d1e', '["*"]', NULL, NULL, '2025-05-19 06:03:07', '2025-05-19 06:03:07'),
	(43, 'App\\Models\\User', 1, 'auth_token', '9f5ece48d5f7a3e4886528651b7c51753b2dc17b3e3f9c9a96953760e0e7ed27', '["*"]', NULL, NULL, '2025-06-03 23:31:10', '2025-06-03 23:31:10'),
	(44, 'App\\Models\\User', 1, 'auth_token', '19fcafcd4d9d7a09ce5be4c7f1ba7528d67f82fdb4625cf9c40d5d32c1b31dc6', '["*"]', NULL, NULL, '2025-06-04 00:31:41', '2025-06-04 00:31:41'),
	(45, 'App\\Models\\User', 1, 'auth_token', '0bc3a7ebc2b78d53feda18284cdd451ce602fbffe828084cc688a0f132331ebc', '["*"]', NULL, NULL, '2025-06-04 00:32:23', '2025-06-04 00:32:23'),
	(46, 'App\\Models\\User', 1, 'auth_token', '59b3fe2de8ea9426ba4e33b8d551ae03fac713c45ca8b379eccf7363a623ee1b', '["*"]', NULL, NULL, '2025-06-04 00:33:15', '2025-06-04 00:33:15'),
	(47, 'App\\Models\\User', 1, 'auth_token', '0ab50045bff9831f5a3d1e94425415295cd41652830441068eae08f3bd2e2abe', '["*"]', NULL, NULL, '2025-06-04 22:57:49', '2025-06-04 22:57:49'),
	(48, 'App\\Models\\User', 1, 'auth_token', '0927804c083107b8dc3a5ad37c4da8657950fc241097e0cb8a70ad1682846a59', '["*"]', NULL, NULL, '2025-06-05 01:52:05', '2025-06-05 01:52:05'),
	(49, 'App\\Models\\User', 1, 'auth_token', '51df3dd2af19a551a4b7efeaf94b1516c84075d11c7a64d04d9cfbb550184611', '["*"]', NULL, NULL, '2025-06-06 20:48:35', '2025-06-06 20:48:35'),
	(50, 'App\\Models\\User', 1, 'auth_token', '8d3a0eeae8a7b4c6d4425c6a80e6c18d60501bcd3029dbd3b954c32088ea9b84', '["*"]', NULL, NULL, '2025-06-07 00:22:36', '2025-06-07 00:22:36'),
	(51, 'App\\Models\\User', 1, 'auth_token', '0c90ff2e6a1d0f0dd0fc5d64d61823ed1d2cd3be81a19cf7b778ac463b46346f', '["*"]', NULL, NULL, '2025-06-07 00:26:23', '2025-06-07 00:26:23'),
	(52, 'App\\Models\\User', 1, 'auth_token', '947a5d1649c8c337e25f1e6a6b650de4bb39279e115e49d37681a6c573758948', '["*"]', NULL, NULL, '2025-06-08 06:23:45', '2025-06-08 06:23:45'),
	(53, 'App\\Models\\User', 6, 'auth_token', 'fc8c4668be41ed0d4176fb2f24913e0fe2ca21b8031665e0e2e02c28dd7897e6', '["*"]', NULL, NULL, '2025-06-08 07:19:21', '2025-06-08 07:19:21'),
	(54, 'App\\Models\\User', 1, 'auth_token', '6cb62df08633703ffe8dd4fcb6e82e0ce0953033d5aac934ea5139b9886a3bc2', '["*"]', NULL, NULL, '2025-06-08 07:20:34', '2025-06-08 07:20:34'),
	(55, 'App\\Models\\User', 1, 'auth_token', 'f74a2d7965b45ab4478b41eaab2eb65a46dcdea4a4fb9faf8345789d091b2701', '["*"]', NULL, NULL, '2025-06-08 07:21:29', '2025-06-08 07:21:29'),
	(56, 'App\\Models\\User', 6, 'auth_token', 'fefd7c1caf9a1aa54d632af9f5758c9b394ab16f16fc5a4ee3d5217e7a134b7a', '["*"]', NULL, NULL, '2025-06-08 07:24:15', '2025-06-08 07:24:15'),
	(57, 'App\\Models\\User', 1, 'auth_token', '705eaddc395c53e5b19712a9074dc07c0963e8fca654148ef55aec41804d55ba', '["*"]', NULL, NULL, '2025-06-08 07:24:33', '2025-06-08 07:24:33'),
	(58, 'App\\Models\\User', 6, 'auth_token', '55f7841ca362e3c43710645221f76e4bf127d250563cc1653e0b5867f27be3d7', '["*"]', NULL, NULL, '2025-06-08 07:25:32', '2025-06-08 07:25:32'),
	(59, 'App\\Models\\User', 1, 'auth_token', 'fbe701bff8606a1d58e5780d96d6aaeba5d491ba6b9665122e329d127cf8b4eb', '["*"]', NULL, NULL, '2025-06-09 00:13:08', '2025-06-09 00:13:08'),
	(60, 'App\\Models\\User', 1, 'auth_token', '3a924de4c43861c5b5698bf5e781264502401c0473cb50d32c5f93e441ded7a7', '["*"]', NULL, NULL, '2025-06-09 02:21:19', '2025-06-09 02:21:19'),
	(61, 'App\\Models\\User', 1, 'auth_token', '135a744cecf7d56cddedf08e8bf7501a374cc4ccf01fd5572052fb0e23b6fbc9', '["*"]', NULL, NULL, '2025-06-09 06:18:45', '2025-06-09 06:18:45'),
	(62, 'App\\Models\\User', 1, 'auth_token', '086e0afe34be1cf8873446ec5068faf0670cd34b3b6fb2df93c126ca5564bdf2', '["*"]', NULL, NULL, '2025-06-09 06:25:46', '2025-06-09 06:25:46'),
	(63, 'App\\Models\\User', 1, 'auth_token', '07c4036580e7f356f3af7b69792ad5464667652ea1887118efe80fdf2c76763f', '["*"]', NULL, NULL, '2025-06-09 06:27:45', '2025-06-09 06:27:45'),
	(64, 'App\\Models\\User', 1, 'auth_token', '703500ef57dc604742d1266500f472fa12c88b80869cf781b943dab18ed80ba4', '["*"]', NULL, NULL, '2025-06-09 19:09:16', '2025-06-09 19:09:16'),
	(65, 'App\\Models\\User', 1, 'auth_token', 'a398e7053081e8df281f339583cff5993c459e7bdeeacecdba45b558b7177472', '["*"]', NULL, NULL, '2025-06-09 23:12:31', '2025-06-09 23:12:31'),
	(66, 'App\\Models\\User', 1, 'auth_token', '2aaea9c1b3d7a21883684dee21dea008d5e9315a72d0cce633b07033eb4378e3', '["*"]', NULL, NULL, '2025-06-10 19:31:09', '2025-06-10 19:31:09'),
	(67, 'App\\Models\\User', 1, 'auth_token', '68d1243b0bfdad58b38a3723675304f94dd5781868f0e8e892479d64a416ffa4', '["*"]', NULL, NULL, '2025-06-10 22:26:03', '2025-06-10 22:26:03'),
	(68, 'App\\Models\\User', 1, 'auth_token', 'e09c832cce7368cbe8e873e2cebbf207025e6615c07625ad35958eabc8fd3a3e', '["*"]', NULL, NULL, '2025-06-10 22:30:58', '2025-06-10 22:30:58'),
	(69, 'App\\Models\\User', 1, 'auth_token', 'af1e912db0643b9da2450c68012e635a666515eac7e8f46735a71f54ea5194a1', '["*"]', NULL, NULL, '2025-06-10 22:31:27', '2025-06-10 22:31:27'),
	(70, 'App\\Models\\User', 1, 'auth_token', '002620a7df4d8328d5fb26fffb4b04774d9025a8b1a8b2e777d8e899da2b5d1e', '["*"]', NULL, NULL, '2025-06-10 22:31:59', '2025-06-10 22:31:59'),
	(71, 'App\\Models\\User', 1, 'auth_token', '893daac9365c69319470fbb2c446ea73af87c2b0556f3f0ff0db2689b85e90e4', '["*"]', NULL, NULL, '2025-06-11 02:09:33', '2025-06-11 02:09:33'),
	(72, 'App\\Models\\User', 1, 'auth_token', 'f497a56bc34109cbd4908d8bd7c02918a8bc3b05bfe5574fa2c8a85387bb7b1b', '["*"]', NULL, NULL, '2025-06-11 06:54:02', '2025-06-11 06:54:02'),
	(73, 'App\\Models\\User', 1, 'auth_token', 'dd3b3edffb4737322df0a85d71818dbc220507cf2aa7f9095428b6bf7cce48f6', '["*"]', NULL, NULL, '2025-06-11 23:20:17', '2025-06-11 23:20:17'),
	(74, 'App\\Models\\User', 1, 'auth_token', 'dd253051c3c2e888ea7fc05a8ce0bc14addf2d978c90db567dad6dda7497b5cb', '["*"]', NULL, NULL, '2025-06-12 00:52:28', '2025-06-12 00:52:28'),
	(75, 'App\\Models\\User', 1, 'auth_token', '484df44b94b932b97ffa6c631312f36a589fd4c0fe9384ad05c555f64a499ca3', '["*"]', NULL, NULL, '2025-06-12 01:39:39', '2025-06-12 01:39:39'),
	(76, 'App\\Models\\User', 1, 'auth_token', 'ca3a01be90314159eb07169762366b7f3ac57e12da3502d77fe95622cab1f83b', '["*"]', NULL, NULL, '2025-06-12 06:17:58', '2025-06-12 06:17:58'),
	(77, 'App\\Models\\User', 1, 'auth_token', '596ad37b8c2afe72915fe15ad66af8f371172451a3b7a5b80422439c24f1aa27', '["*"]', NULL, NULL, '2025-06-12 23:08:27', '2025-06-12 23:08:27'),
	(78, 'App\\Models\\User', 1, 'auth_token', 'b9907940f297e2cca79176982c428743f06019d08d0587db0f6e556f479274f6', '["*"]', NULL, NULL, '2025-06-13 02:11:03', '2025-06-13 02:11:03'),
	(79, 'App\\Models\\User', 1, 'auth_token', 'c32bcf58a2d74e9a153b909fab78153e07b3607b1e87a7a7ceeab799b07bd969', '["*"]', NULL, NULL, '2025-06-13 05:51:25', '2025-06-13 05:51:25'),
	(80, 'App\\Models\\User', 1, 'auth_token', '4441edbb8c64fdcadd088ff669d3ab46917396e53f8f87cc1ed79948a2c67323', '["*"]', NULL, NULL, '2025-06-13 05:52:03', '2025-06-13 05:52:03'),
	(81, 'App\\Models\\User', 1, 'auth_token', 'c6db8dbae091c35d63f4108e1794ab4d3ef1373f43482fab2b49ae9e4e677f3e', '["*"]', NULL, NULL, '2025-06-13 06:37:48', '2025-06-13 06:37:48'),
	(82, 'App\\Models\\User', 7, 'auth_token', '313c86e41dd0086d0905cd9b234c46e60e347fc83cf5c7630f43d15c30f33163', '["*"]', NULL, NULL, '2025-06-13 07:48:40', '2025-06-13 07:48:40'),
	(83, 'App\\Models\\User', 1, 'auth_token', 'f77c4f34d19346f6ac8a16a715180cc5d2bdd74937d7eaaa566fbd4f03dc22e6', '["*"]', NULL, NULL, '2025-06-13 07:49:56', '2025-06-13 07:49:56'),
	(84, 'App\\Models\\User', 1, 'auth_token', 'ed4c53d5466c2d2161da6e2db9baee728dd8dea1a917f7d435390e70c4dc7447', '["*"]', NULL, NULL, '2025-06-13 07:51:07', '2025-06-13 07:51:07'),
	(85, 'App\\Models\\User', 1, 'auth_token', '881c37beee6539cf349ec9ee4983d3e34d93ca2dbf75bbc9c8a93d260082cdec', '["*"]', NULL, NULL, '2025-06-13 19:22:10', '2025-06-13 19:22:10'),
	(86, 'App\\Models\\User', 1, 'auth_token', '642b8dc48b625f09b0ba55cf2b4547265415a1ac044d361790bf648f4be9c84b', '["*"]', NULL, NULL, '2025-06-13 21:45:31', '2025-06-13 21:45:31'),
	(87, 'App\\Models\\User', 1, 'auth_token', '5e204e201e9594c6253008d10031c8b675de624cc88791729a2d17f6a1c5d623', '["*"]', NULL, NULL, '2025-06-14 07:06:52', '2025-06-14 07:06:52'),
	(88, 'App\\Models\\User', 1, 'auth_token', '32cbe009e08bd5b80f68cd7b5130878d932d57b8928988e2e770a1f3f917a24b', '["*"]', NULL, NULL, '2025-06-14 18:35:34', '2025-06-14 18:35:34'),
	(89, 'App\\Models\\User', 1, 'auth_token', 'cf52ff53ada2719a57e87096b6e657fbf163c0911dfcf3080e2d404068feff94', '["*"]', NULL, NULL, '2025-06-15 00:40:52', '2025-06-15 00:40:52'),
	(90, 'App\\Models\\User', 1, 'auth_token', '1f97c22343d084fa2fd63935b363df4cd61ad9962349eec5daee750056a4e463', '["*"]', NULL, NULL, '2025-06-15 00:41:13', '2025-06-15 00:41:13'),
	(91, 'App\\Models\\User', 1, 'auth_token', '116acc386f948c06265cc3e65a18071aa7552d10bc80fc565011f7918933120d', '["*"]', NULL, NULL, '2025-06-15 03:13:35', '2025-06-15 03:13:35'),
	(92, 'App\\Models\\User', 1, 'auth_token', 'af8a13c24d739ee600c9aac31ef3beabc775bbff448952b1d4628703b65b8b03', '["*"]', NULL, NULL, '2025-06-15 06:10:21', '2025-06-15 06:10:21'),
	(93, 'App\\Models\\User', 1, 'auth_token', '730882630edfd38fb7d2ea7a15a082f39028c358253c828a633fe15bda10bf42', '["*"]', NULL, NULL, '2025-06-15 18:42:52', '2025-06-15 18:42:52'),
	(94, 'App\\Models\\User', 1, 'auth_token', '20d72ff6becda328cee3206ee6f20f592e0914555fe679178c1e8f5877c20c68', '["*"]', NULL, NULL, '2025-06-16 16:08:32', '2025-06-16 16:08:32'),
	(95, 'App\\Models\\User', 1, 'auth_token', 'a659e238ef3161c12596fa8141239c7d280b648fa26dce0d7a555e33361acfcb', '["*"]', NULL, NULL, '2025-06-16 19:00:32', '2025-06-16 19:00:32'),
	(96, 'App\\Models\\User', 1, 'auth_token', '5b99be02782f2dd5c46b35578e6facffc81e24027c84561370ee6f8f414ea417', '["*"]', NULL, NULL, '2025-06-16 22:48:39', '2025-06-16 22:48:39'),
	(97, 'App\\Models\\User', 1, 'auth_token', 'bf9bd47f89ca0ff17c13e5b61b649db15b1fbc26a6a2f671b9d231220d210904', '["*"]', NULL, NULL, '2025-06-17 00:48:01', '2025-06-17 00:48:01'),
	(98, 'App\\Models\\User', 1, 'auth_token', '63e93946e95100b67ba687b4356a22183b1ba9a2b68f33156e55b834f1995285', '["*"]', NULL, NULL, '2025-06-17 06:44:17', '2025-06-17 06:44:17'),
	(99, 'App\\Models\\User', 1, 'auth_token', '626730bc6f9c71f5a63a1d6acdcbe34cff23f54d71b51a005405876f7bb062dd', '["*"]', NULL, NULL, '2025-06-17 22:51:15', '2025-06-17 22:51:15'),
	(100, 'App\\Models\\User', 1, 'auth_token', '8b147840a1ba914e552064681c08f963d284b1d2de64d9813e8d29dbb620b8c1', '["*"]', NULL, NULL, '2025-06-17 22:51:21', '2025-06-17 22:51:21'),
	(101, 'App\\Models\\User', 1, 'auth_token', '6a4e2064b0825c9bcc20efbfcb136f0286257a71ea3a054e4dc5d2380633db9b', '["*"]', NULL, NULL, '2025-06-18 02:53:50', '2025-06-18 02:53:50'),
	(102, 'App\\Models\\User', 1, 'auth_token', 'c037b2a812b4c8af47dd4f47e9aa8817215c982c65c227abdfc1aa9a0c66a2cb', '["*"]', NULL, NULL, '2025-06-18 05:19:11', '2025-06-18 05:19:11'),
	(103, 'App\\Models\\User', 1, 'auth_token', '86499fab86b000e8d59b8b364d30f0662a94c7fe40de3f00ae6bfd057085b345', '["*"]', NULL, NULL, '2025-06-18 06:33:35', '2025-06-18 06:33:35'),
	(104, 'App\\Models\\User', 9, 'auth_token', '7309d641d100daf4aed632d0583e8aea93cd414ca66a1cb9f64f2f975b7443a8', '["*"]', NULL, NULL, '2025-06-18 07:07:55', '2025-06-18 07:07:55'),
	(105, 'App\\Models\\User', 1, 'auth_token', '014096c65b949fcd63668b321267b300284781ab8e6d0a71415dc7a805b84c54', '["*"]', NULL, NULL, '2025-06-18 07:10:13', '2025-06-18 07:10:13'),
	(106, 'App\\Models\\User', 1, 'auth_token', '554d6ac9812e79faccd1086ae40262d19bf9eca24bba7c6a0337990bbeb202d1', '["*"]', NULL, NULL, '2025-06-18 07:11:24', '2025-06-18 07:11:24'),
	(107, 'App\\Models\\User', 9, 'auth_token', '57bb3559d3349ac948e838b07f6b750d7670e9bd15471af2254dbbc83bd5f2d6', '["*"]', NULL, NULL, '2025-06-18 07:18:31', '2025-06-18 07:18:31'),
	(108, 'App\\Models\\User', 1, 'auth_token', '84e2064f8df2b5081596e987f54874d5790eccf6aed56397109ea1a8a5bbff5d', '["*"]', NULL, NULL, '2025-06-18 07:19:04', '2025-06-18 07:19:04'),
	(109, 'App\\Models\\User', 1, 'auth_token', '948ac47927faf2fccbd289a6bfca34fade498f6b725f8ee028fb06e69907be3d', '["*"]', NULL, NULL, '2025-06-18 08:11:10', '2025-06-18 08:11:10'),
	(110, 'App\\Models\\User', 1, 'auth_token', '6a36bec47ab86e739fb1885bb423dd6d4896cca75c357d659a86449b724663de', '["*"]', NULL, NULL, '2025-06-18 19:12:41', '2025-06-18 19:12:41'),
	(111, 'App\\Models\\User', 9, 'auth_token', 'fd3a4d8994c3ada7bbfc263df5db7e19558a68952ff542148a7517ffa8ceda81', '["*"]', NULL, NULL, '2025-06-18 19:25:21', '2025-06-18 19:25:21'),
	(112, 'App\\Models\\User', 9, 'auth_token', 'a4531f5ee500ade60b92ac3bf7d58cae99ad1946d331962ccd0fe46885e5bd6b', '["*"]', NULL, NULL, '2025-06-18 19:50:47', '2025-06-18 19:50:47'),
	(113, 'App\\Models\\User', 1, 'auth_token', '64462f28744f6fac436ec6b78ca14c8d02ac56e22df3eaa44c8c6fc2666c0272', '["*"]', NULL, NULL, '2025-06-18 19:51:08', '2025-06-18 19:51:08'),
	(114, 'App\\Models\\User', 1, 'auth_token', '6f0905200e4fe00a27a06e267d187fe77ba5da091169a43855a44fa83f501a0f', '["*"]', NULL, NULL, '2025-06-18 19:54:19', '2025-06-18 19:54:19'),
	(115, 'App\\Models\\User', 6, 'auth_token', 'd6e48bd25d160d5a4527686e5af8ba32800b7c6b174af91074f9479c89713f0b', '["*"]', NULL, NULL, '2025-06-18 19:56:59', '2025-06-18 19:56:59'),
	(116, 'App\\Models\\User', 1, 'auth_token', '9d72121c9f84a8c2bbf3e131af784d90820d21a6dc98dd86e8c82a6e7abb3688', '["*"]', NULL, NULL, '2025-06-18 19:57:34', '2025-06-18 19:57:34'),
	(117, 'App\\Models\\User', 11, 'auth_token', '65c3b93c4d81c0ced63849b2784f73ebad0483b75026bd68e90afc7e6aba3893', '["*"]', NULL, NULL, '2025-06-18 19:58:40', '2025-06-18 19:58:40'),
	(118, 'App\\Models\\User', 1, 'auth_token', '42015496b0620549cb34ffeb85a4ec52cba913804620f00de548fb93ea6c6eb7', '["*"]', NULL, NULL, '2025-06-18 19:59:03', '2025-06-18 19:59:03');

-- Dumping structure for table basogilang_apps.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.sessions: ~0 rows (approximately)

-- Dumping structure for table basogilang_apps.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `position_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `harga` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table basogilang_apps.users: ~4 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone`, `photo`, `active`, `position_code`, `created_at`, `updated_at`, `harga`) VALUES
	(1, 'super', 'ikram@gmail.com', '$2y$12$iMqoGluGovHnwCIQ.0Xr1.FJ.fx5hdO9039CMjKx9ObOQHRkQ.Mgq', '+6281352557069', 'Ikon 4.png', 1, 'OWN', '2025-04-29 22:25:02', '2025-06-18 07:11:04', 0),
	(7, 'Asep', 'asep@gmail.com', '$2y$12$iMqoGluGovHnwCIQ.0Xr1.FJ.fx5hdO9039CMjKx9ObOQHRkQ.Mgq', '12312312312', NULL, 1, 'STF', '2025-06-13 07:45:45', '2025-06-13 07:45:45', 0),
	(9, 'Admin 2', 'asdasd@gmail.com', '$2y$12$G.a9vyLIiCBF1285c7IixuQKsF/S7HS2B51Mr6qccyYRtqYtcui/e', '12312312312', 'download.jpg', 1, 'SA', '2025-06-18 07:07:13', '2025-06-18 19:50:21', 0),
	(11, 'Gilang', 'app.basogilang@gmail.com', '$2y$12$3JNh/y9NYkv47LAXaRfin.0XsCfO5B/AnQ1FJGxopHzN91lW14K3i', '+62 878-2405-6121', NULL, 1, 'OWN', '2025-06-18 19:58:17', '2025-06-18 19:58:17', 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
