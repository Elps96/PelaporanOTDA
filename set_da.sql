/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100432
 Source Host           : localhost:3306
 Source Schema         : set_da

 Target Server Type    : MySQL
 Target Server Version : 100432
 File Encoding         : 65001

 Date: 12/08/2025 11:39:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp(0) NOT NULL DEFAULT current_timestamp(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2025_07_30_032653_add_opd_to_users_table', 2);

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id`) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('5hspnJT7uX0o2cb6K8A8WjrlCX4Q5QRAOASInXuy', 4, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiTUQ3UjdldVV4cEtEZWJidHR0WUNad2NrazU1VlJrdnhDWVRURmdVMCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vbG9jYWxob3N0OjgwMDAvbG9naW4iO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo0O3M6NToidGFodW4iO3M6NDoiMjAyNCI7czozOiJvcGQiO3M6NToiSFVLVU0iO30=', 1754962058);
INSERT INTO `sessions` VALUES ('Bg64bX1EQhfVkp7mkWkBsfZLKtHdSpOoz3vieLqk', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiS2haM1ExNldMcGFha0dhMGpiUGxVQjZpRko0NnhDQjd6amRpUFVTSCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjIxOiJodHRwOi8vbG9jYWxob3N0OjgwMDAiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTozO3M6NToidGFodW4iO3M6NDoiMjAyNCI7czozOiJvcGQiO3M6MzoiQktEIjt9', 1754973135);

-- ----------------------------
-- Table structure for tb_indikator_komponen_otda
-- ----------------------------
DROP TABLE IF EXISTS `tb_indikator_komponen_otda`;
CREATE TABLE `tb_indikator_komponen_otda`  (
  `Jenis` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `KodePertanyaan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `No` tinyint NULL DEFAULT NULL,
  `Tahun` int NULL DEFAULT NULL,
  `Indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DefinisiOperasional` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Rumus` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Capaian` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BuktiPendukung` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `FileBuktiDukung` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `OPDPengampu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RumusIsiAtas` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RumusIsiBawah` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_indikator_komponen_otda
-- ----------------------------
INSERT INTO `tb_indikator_komponen_otda` VALUES ('FKDH', 'FKDH001', 1, 2024, 'Ketepatan waktu penyampaian LKPJ kepada DPRD', 'Ketepatan Waktu Penyampaian LKPJ kepada DPRD', 'Tepat Waktu/Tidak Tepat Waktu', 'Tepat Waktu', 'Untuk Penyampaian LKPJ melampirkan Surat Pengantar Penyampaian LKPJ kepada DPRD dan tanda terima Penyampaian LKP', NULL, NULL, 'PEMERINTAHAN', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('FKDH', 'FKDH002', 2, 2024, 'Ketepatan waktu pelaksanaan pembahasan LKPJ oleh DPRD', 'Ketepatan Waktu Pelaksanaan Pembahasan LKPJ oleh DPRD', 'Tepat Waktu/Tidak Tepat Waktu 1. Undangan Pembahasan LKPJ : Ada/Tidak Ada 2. Risalah Rapat : Ada/Tidak Ada 3. Berita Acara : Ada/Tidak Ada 4. Keputusan DPRD tentang Rekomendasi : Ada/Tidak Ada 5. Dokumentasi: Ada/Tidak Ada', NULL, 'Untuk Pembahasan LKPJ melampirkan Undangan Pembahasan LKPJ,Risalah -Rapat, Berita Acara, Keputusan DPRD tentang Rekomendasi dan Dokumentasi', NULL, NULL, 'PEMERINTAHAN', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('FKDH', 'FKDH004', 4, 2024, 'Penyampaian Rekomendasi LKPJ Kabupaten/Kota kepada Bupati/Walikota dan Tembusan kepada Gubernur dan Menteri Dalam negeri', 'Penyampaian Rekomendasi LKPJ -Kab/Kota kepada BupatilWalikota dan Tembusan kepada Gubernur dan Menteri Dalam Negeri', 'Ada/Tidak Ada', NULL, 'Untuk Penyampaian Rekomendasi LKPJ Kab/Kota kepada Bupati/Walikota dan Tembusan kepada Gubernur dan Menteri Dalam Negeri melampirkan Surat pengantar dan Tanda Terima', NULL, NULL, 'PEMERINTAHAN', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('PHD', 'PHD002', 2, 2024, 'Ketepatan Penetapan Perda APBD Tahun N', NULL, 'Tepat atau Tidak Tepat', NULL, NULL, NULL, NULL, 'HUKUM', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('PHD', 'PHD003', 3, 2024, 'Persentase Penetapan RanPerda Tahun N', NULL, '((Jumlah Penetapan Ranperda Berdasarkan Prolegda Tahun N)/(Jumlah Ranperda yang tertuang dalam Prolegda Tahun N))*100', NULL, NULL, NULL, NULL, 'HUKUM', 'Jumlah Penetapan Ranperda Berdasarkan Prolegda Tahun N', 'Jumlah Ranperda yang tertuang dalam Prolegda Tahun N');
INSERT INTO `tb_indikator_komponen_otda` VALUES ('KKPD', 'KKPD001', 1, 2024, 'Kepatuhan Pemda dalam melaksanakan putusan pengadilan yang berkekuatan hukum tetap (PTUN Undang-undang Nomor 30 Tahun 2014 tentang Administrasi Pemerintahan)', 'Pemerintah Daerah melaksanakan Keputusan dan/atau Tindakan yang sah dan Keputusan yang telah dinyatakan tidak sah atau dibatalkan oleh Pengadilan, pejabat yang bersangkutan, atau Atasan Pejabat, dan mematuhi putusan Pengadilan yang telah berkekuatan hukum', 'YA/TIDAK', NULL, 'Putusan pengadilan dan surat keputusan kepala daerah', NULL, NULL, 'HUKUM', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('KKPD', 'KKPD002', 2, 2024, 'Kepatuhan Pemda dalam menindaklanjuti peraturan perundang-undangan dibidang kelembagaan perangkat daerah. (PP 18/2016; PP 72/2019; PP 106/2021; beserta peraturan dibawahnya)', 'Pemerintah Daerah telah menerbitkan: a. Perda (pembentukan dan susunan perangkat daerah) (pasal 3 ayat 1 PP 18/2016). b. Perkada (kedudukan, susunan organisasi, tugas dan fungsi, serta tata kerja perangkat daerah) terkait kelembagaan perangkat daerah (pas', 'YA/TIDAK', NULL, 'Copy halaman depan, belakang serta pasal yang menunjukan bunyi peraturan Perda dan perkada yang diterbitkan', NULL, NULL, 'ORGANISASI', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('KKPD', 'KKPD003', 3, 2024, 'Kepatuhan Pemda dalam melaksanakan rekomendasi Menteri Dalam Negeri terkait kebijakan penyederhanaan birokrasi (penyederhanaan struktur organisasi dan penyetaraan jabatan)', 'Pemerintah daerah telah melaksanakan rekomendasi menteri dalam negeri persetujuan penyederhanaan struktur organisasi dan penyetaraan jabatan. Data dukung: 1. Persetujuan Menteri Dalam Negeri terkait penyederhanaan struktur organisasi 2. Persetujuan Menter', '((Jumlah tindaklanjut kepatuhan pemda)/(Jumlah rekomendasi Mendagri))*100', NULL, NULL, NULL, NULL, 'ORGANISASI', 'Jumlah tindaklanjut kepatuhan pemda', 'Jumlah rekomendasi Mendagri');
INSERT INTO `tb_indikator_komponen_otda` VALUES ('KKPD', 'KKPD004', 4, 2024, 'Persentase Jabatan Struktural yang Terisi', NULL, '(Jabatan Struktural yang terisi (Definitif)/Jabatan Struktural yang ada)*100', NULL, NULL, NULL, NULL, 'BKPSDM', 'Jabatan Struktural yang terisi (Definitif)', 'Jumlah Kelompok Jabatan Fungsional');
INSERT INTO `tb_indikator_komponen_otda` VALUES ('KKPD', 'KKPD005', 5, 2024, 'Jumlah Diklat Jabatan Fungsional Tahun N', NULL, '(Jumlah Kegiatan Diklat Jabatan Fungsional/Jumlah Kelompok Jabatan Fungsional)*100', NULL, NULL, NULL, NULL, 'BKPSDM', 'Jumlah Kegiatan Diklat Jabatan Fungsional', 'Jumlah Kelompok Jabatan Fungsional');
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPKD001', 1, 2024, 'Monitoring Center for Prevention Tahun N', NULL, 'Nilai MCP Tahun N', NULL, NULL, NULL, NULL, 'INSPEKTORAT', 'Nilai MCP Tahun N', NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD002', 2, 2024, 'Jumlah Program yang Mendukung 7 Prioritas Nasional Tahun 2024 Berdasarkan Perpres No 52 Tahun 2023', 'Program-Program yang Mendukung 7 Program Prioritas Nasional', '(Jumlah Program yang Mendukung 7 Prioritas Nasional Tahun 2024 Berdasarkan Perpres No 52 Tahun 2023/…)*100', NULL, NULL, NULL, NULL, 'BKD', 'Jumlah Program yang Mendukung 7 Prioritas Nasional Tahun 2024 Berdasarkan Perpres No 52 Tahun 2023', '- *');
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD003', 3, 2024, 'Persentase Realisasi Belanja Urusan Pelayanan Dasar Tahun N', NULL, '(Realisasi Belanja Urusan Pelayanan Dasar Tahun N/Anggaran Belanja Urusan Pelayanan Dasar Tahun N)*100', NULL, NULL, NULL, NULL, 'BKD', 'Realisasi Belanja Urusan Pelayanan Dasar Tahun N', 'Anggaran Belanja Urusan Pelayanan Dasar Tahun N');
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD004', 4, 2024, 'Persentase Penurunan SILPA', NULL, '((Nilai SILPA Tahun N dikurangi Nilai SILPA Tahun - N))/Nilai SILPA Tahun - N)*100', NULL, NULL, NULL, NULL, 'BKD', 'Nilai SILPA Tahun N dikurangi Nilai SILPA Tahun - N', 'Nilai SILPA Tahun - N');
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD005', 5, 2024, 'Persentase Penurunan SILPA', NULL, '((Nilai Aset Tetap Tahun N dikurang Nilai Aset Tetap Tahun - N)/(Nilai Aset Tetap Tahun - N	))*100', NULL, NULL, NULL, NULL, 'BKD', 'Nilai Aset Tetap Tahun N dikurang Nilai Aset Tetap Tahun - N', 'Nilai Aset Tetap Tahun - N');
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD006', 6, 2024, 'Tindaklanjut Rekomendasi BPK Tahun Anggaran 2023', NULL, '(Tindaklanjut Rekomendasi BPK Tahun Anggaran Tahun N / Rekomendasi BPK Tahun Anggaran Tahun N) * 100', NULL, NULL, NULL, NULL, 'INSPEKTORAT', 'Tindaklanjut Rekomendasi BPK Tahun Anggaran Tahun N', 'Rekomendasi BPK Tahun Anggaran Tahun N');
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD007', 7, 2024, 'Penilaian Kepatuhan Penyelenggaraan Pelayanan Publik Tahun N', NULL, 'Nilai Kepatuhan Penyelenggaraan Pelayanan Publik Tahun N', NULL, NULL, NULL, NULL, 'ORGANISASI', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD008', 8, 2024, 'Keberadaan Mall Pelayanan Publik', NULL, 'Ada atau Tidak', NULL, NULL, NULL, NULL, 'DPMPTSP', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD009', 9, 2024, 'Inovasi Daerah (sesuai dengan PP 38/2017)', NULL, 'Jumlah Inovasi Daerah (Jenis dan Manfaat)', NULL, NULL, NULL, NULL, 'ORGANISASI', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD010', 10, 2024, 'Kerjasama Daerah', NULL, NULL, NULL, NULL, NULL, NULL, 'PEMERINTAHAN', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD011', 11, 2024, 'Jumlah Kerjasama Daerah', NULL, 'Kerjasama yang masih berlaku dan Manfaatnya', NULL, NULL, NULL, NULL, 'PEMERINTAHAN', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD012', 12, 2024, 'Jumlah Penanganan Konflik Tahun N', NULL, 'Jumlah Penanganan Konflik Tahun N', NULL, NULL, NULL, NULL, 'KESBANGPOL/SATPOL PP', NULL, NULL);
INSERT INTO `tb_indikator_komponen_otda` VALUES ('EKPD', 'EKPD013', 13, 2024, 'Prevalensi Stunting (Pendek Dan Sangat Pendek) Pada Balita', NULL, '(Jumlah balita umur 0 sampai 59 bulan dengan panjang badan atau tinggi badan kurang dari -2 Standar Deviasi pada suatu wilayah dan kurun waktu tertentu / Jumlah balita umur 0 sampai 59 bulan yang diukur panjang badan atau tinggi badan pada suatu wilayah dan kurun waktu yang sama', NULL, NULL, NULL, NULL, 'DINKES', 'Jumlah balita umur 0 sampai 59 bulan dengan panjang badan atau tinggi badan kurang dari -2 Standar Deviasi pada suatu wilayah dan kurun waktu tertentu', 'Jumlah balita umur 0 sampai 59 bulan yang diukur panjang badan atau tinggi badan pada suatu wilayah dan kurun waktu yang sama');

-- ----------------------------
-- Table structure for tb_input_capaian
-- ----------------------------
DROP TABLE IF EXISTS `tb_input_capaian`;
CREATE TABLE `tb_input_capaian`  (
  `KodePertanyaan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Capaian` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `FileBukti` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Keterangan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `InputIsianAtas` int NULL DEFAULT NULL,
  `InputIsianBawah` int NULL DEFAULT NULL,
  `UpdateAt` datetime(0) NULL DEFAULT NULL,
  `InputAt` datetime(0) NULL DEFAULT NULL,
  `Tahun` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_input_capaian
-- ----------------------------

-- ----------------------------
-- Table structure for tb_input_capaian_inovasi
-- ----------------------------
DROP TABLE IF EXISTS `tb_input_capaian_inovasi`;
CREATE TABLE `tb_input_capaian_inovasi`  (
  `KodePertanyaan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Nama` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Gambar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `IsAktif` int NULL DEFAULT NULL,
  `UpdateAt` datetime(0) NULL DEFAULT NULL,
  `InputAt` datetime(0) NULL DEFAULT NULL,
  `Tahun` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SKPD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `No` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`No`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_input_capaian_inovasi
-- ----------------------------

-- ----------------------------
-- Table structure for tb_rekomendasi_dprd
-- ----------------------------
DROP TABLE IF EXISTS `tb_rekomendasi_dprd`;
CREATE TABLE `tb_rekomendasi_dprd`  (
  `No` int NULL DEFAULT NULL,
  `KodeRekomendasiDPRD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RekomendasiDPRD` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Tahun` int NULL DEFAULT NULL,
  `TindakLanjut` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `OPDPengampu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `IsAktif` tinyint(1) NULL DEFAULT NULL,
  `UpdateAt` datetime(0) NULL DEFAULT NULL,
  `InputAt` datetime(0) NULL DEFAULT NULL,
  `NamaOPDPengampu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_rekomendasi_dprd
-- ----------------------------
INSERT INTO `tb_rekomendasi_dprd` VALUES (1, 'REKDPRD001', 'Perekonomian Kabupaten Karanganyar sampai dengan tahun 2024, telah sepenuhnya pulih normal kembali sejak Pandemi Covid-19 tahun 2020/2022. Berdasarkan data capaian tahun 2024 yang dilaporkan dalam dokumen LKPJ Bupati Karanganyar Tahun Anggaran 2024 bahwa, ekonomi Kabupaten Karanganyar tahun 2024 tumbuh positif 5,54%, sedikit melambat dibanding dengan capaian tahun 2023 yang tumbuh 5,53% juga lebih rendah dari tahun 2022 yang tumbuh 5,87%. Namun demikian Tingkat pengangguran Terbuka (TPT) tahun 2024 turun -0,88% dibanding tahun sebelumnya, dimana TPT tahun 2024 sebesar 3,47% dari 4,35% di tahun 2023 sedangkan Angka Kemiskinan turun sedikit sebesar 0,2% dari tahun 2023, persentase penduduk miskin menjadi 9,59% ditahun 2024 dari 9,79% di tahun 2023.', 2024, NULL, 'BAPERLITBANG', NULL, NULL, NULL, 'BAPERLITBANG');
INSERT INTO `tb_rekomendasi_dprd` VALUES (2, 'REKDPRD002', 'Ditengah situasi ekonomi Nasional dan ekonomi global yang belum sepenuhnya menggembirakan, maka perekonomian makro Kabupaten Karanganyar yang telah pulih kembali setelah pandemi, dimana pertumbuhan ekonomi tumbuh diatas 5% pada tiga tahun terakhir tentu patut diapresiasi. Faktor pendukung keberhasilan maupun hambatan (baik eksternal maupun internal) penting untuk disajikan dalam dokumen LKPJ dengan jujur dan transparan agar para penentu kebijakan memperoleh pelajaran penting dari kinerja ini, sehingga hasil kerja ini dapat ditingkatkan lebih baik lagi pada masa yang akan datang.', 2024, NULL, 'PEMERINTAHAN', NULL, NULL, NULL, 'Sekretariat LKPJ');
INSERT INTO `tb_rekomendasi_dprd` VALUES (3, 'REKDPRD003', 'Capaian indikator Indeks Pembangunan Manusia (IPM), sebagai indikator capaian pembangunan manusia tahun 2024 capaiannya IPM meningkat pada level antara 75 - 80 yaitu sebesar 78,11 meningkat dibanding tahun sebelumnya, dimana tahun 2023 IPM Kabupaten Karanganyar sebesar 77,31. (kinerja IPM masih standar artinya belum ada lompatan/ percepatan kinerja Pembangunan kualitas Sumber Daya Manusia/SDM). IPM Kabupaten Karanganyar berada di atas IPM Provinsi Jawa Tengah. Hal ini menunjukkan bahwa pembangunan di Kabupaten Karanganyar berada di atas rata-rata kemajuan dari IPM Provinsi Jawa Tengah.', 2024, NULL, 'BAPERLITBANG', NULL, NULL, NULL, 'BAPERLITBANG');
INSERT INTO `tb_rekomendasi_dprd` VALUES (4, 'REKDPRD004', 'Secara umum dalam Buku LKPJ Bupati Karanganyar Tahun Anggaran 2024 tidak terdapat ringkasan atau resume yang menyatakan capaian masing-masing urusan, sehingga kinerja masing-masing urusan tidak dapat diketahui. Namun bila melihat dari sisi penyerapan anggaran, semua kegiatan tercapai sesuai rencana.', 2024, NULL, 'PEMERINTAHAN', NULL, NULL, NULL, 'Sekretariat LKPJ');
INSERT INTO `tb_rekomendasi_dprd` VALUES (5, 'REKDPRD005', 'Penyajian Capaian Kinerja Urusan Pemerintahan Wajib Yang Berkaitan Dengan Pelayanan Dasar dan pelaksanaan Urusan Pemerintahan Wajib Yang Tidak Berkaitan Dengan Pelayanan Dasar agar tidak hanya melaporkan realisasi belanja kegiatan di setiap urusan, tetapi juga melaporkan input, output, outcome dan impact dari program/kegiatan yang dilaksanakan sebagaimana termuat dalam indikator kinerja setiap urusan pemerintah daerah.', 2024, NULL, 'PEMERINTAHAN', NULL, NULL, NULL, 'Sekretariat LKPJ');
INSERT INTO `tb_rekomendasi_dprd` VALUES (6, 'REKDPRD006', 'LKPJ sebagai progress report, semestinya bisa memberikan gambaran progress pencapaian/ kinerja pembangunan tahun anggaran (2024) yang dievaluasi dengan apa yang direncanakan dan sekaligus dibandingkan dengan tahun akhir perencanaan sehingga dapat memberikan solusi/akselerasi pencapaian target pada perencanaan ke depan di Kabupaten Karanganyar. LKPJ sebagai laporan tahunan seyogyanya tidak hanya memuat realisasi program dan kegiatan (anggaran dan indikator kegiatan), namun juga dikaitkan dengan ketercapaian tujuan dan sasaran (indikator) pada level pembangunan daerah. Penyederhanaan Format Dokumen LKPJ perlu ditindak lanjuti, agar DPRD dalam menjalankan tugas dan wewenang menilai dokumen LKPJ dapat membacanya dengan benar dan menganalisisnya dengan tepat, selanjutnya dari hasil pembacaan dan analisis tersebut dapat menjadi dasar perumusan rekomendasi perbaikan jalannya pemerintahan pada tahun yang akan datang.', 2024, NULL, 'PEMERINTAHAN', NULL, NULL, NULL, 'Sekretariat LKPJ');
INSERT INTO `tb_rekomendasi_dprd` VALUES (7, 'REKDPRD007', 'Dalam penyebutan dasar hukum LKPJ Bupati Karanganyar Tahun Anggaran 2024, belum ada ketentuan peraturan perundang-undangan yang berkaitan dengan pengaturan Aparatur Sipil Negara (ASN) dan peraturan berkaitan dengan tugas pembantuan dan penyelenggaraan tugas pemerintah daerah di masa transisi menjelang pemilu kepala daerah serentak nasional tahun 2024, yang membedakan dengan kepala daerah definitif terkait tugas, wewenang, kewajiban, larangannya, misalnya : ', 2024, NULL, 'PEMERINTAHAN', NULL, NULL, NULL, 'Sekretariat LKPJ');
INSERT INTO `tb_rekomendasi_dprd` VALUES (8, 'REKDPRD008', 'Dalam penyajian LKPJ Bupati Karanganyar untuk kondisi luas wilayah, tidak disampaikan perkembangan luas wilayah, tanah sawah, bukan sawah dan bukan pertanian dengan menempatkan sumber data dari perangkat daerah yang membidangi urusan pemerintahan tersebut.', 2024, NULL, 'PEMERINTAHAN', NULL, NULL, NULL, 'Sekretariat LKPJ, Karanganyar dalam angka');
INSERT INTO `tb_rekomendasi_dprd` VALUES (9, 'REKDPRD009', 'Dalam penyajian LKPJ untuk kondisi geografi dan demografi tidak dilengkapi dengan tabel yang menunjukkan keberadaan kecamatan, desa/kelurahan, RW/RT dengan menuangkan sumber data yang jelas dan akurat.', 2024, NULL, NULL, NULL, NULL, NULL, 'Sekretariat LKPJ');
INSERT INTO `tb_rekomendasi_dprd` VALUES (10, 'REKDPRD010', 'Dalam penyajian LKPJ untuk kondisi umum demografis, tidak menguraikan komposisi data mengenai kelahiran, kematian dan perpindahan penduduk di suatu wilayah.', 2024, NULL, 'PEMERINTAHAN', NULL, NULL, NULL, 'Sekretariat LKPJ');
INSERT INTO `tb_rekomendasi_dprd` VALUES (11, 'REKDPRD011', 'Dalam penyajian LKPJ untuk realisasi pendapatan menurut jenis pendapatan, tidak disampaikan alasan tidak terpenuhinya realisasi dengan target/perencanaannya, serta adanya SILPA bebas/terikat, tidak disampaikan data-data terkait penggunaan anggaran untuk kegiatan apa saja. Realisasi Pendapatan daerah tahun 2024 melampaui target sebesar Rp.10,54 M lebih, atau ter-realisasi sebesar 100,4% dari target pendapatan yang ditetapkan dalam APBD Perubahan 2024. Sementara realiasi belanja daerah tidak terserap sebesar Rp.136,5 M lebih, atau ter-realisasi 94,8% dari alokasi, sehingga terjadi pergeseran defisit anggaran daerah di tahun 2024. APBD tahun 2024 setelah perubahan semula diproyeksi Defisit Rp.107,8 M pada realisasinya justru surplus sebesar Rp. 39,0 M lebih.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (12, 'REKDPRD012', 'Dalam penyampaian Pendapatan Asli Daerah (PAD) Tahun Anggaran 2024, pada sub Retribusi Daerah, ada kenaikan Retribusi sebesar Rp 188.926.096.068,- (seratus delapan puluh delapan milyard, sembilan ratus dua puluh enam juta, sembilan puluh enam ribu, enam puluh delapan rupiah) atau naik sekitar 2.220,49 % (dua ribu dua ratus dua puluh ribu, koma empat puluh sembilan persen), tidak menyajikan data sumber kenaikannya darimana saja.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (13, 'REKDPRD013', 'Dalam uraian PAD pada sub Lain-lain Pendapatan Asli Daerah yang Sah, terdapat pengurangan 94,48% dari Rp 167.702.280.700,- (seratus enam puluh tujuh miliar tujuh ratus dua juta dua ratus delapan puluh ribu tujuh ratus rupiah) menjadi tinggal Rp 9.261.075.300,- (sembilan miliar dua ratus enam puluh satu juta tujuh puluh lima ribu tiga ratus rupiah). Tidak disampaikan penjelasan rincian sumber Pendapatan Asli Daerah itu dari mana saja dan alasan turun/pengurangan.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (14, 'REKDPRD014', 'Dalam uraian PAD pada sub Pendapatan Transfer Antar Daerah, penerimaan dari Pendapatan Transfer Antar Daerah Tahun Anggaran 2024 direncanakan sejumlah Rp 151.546.569.590,- (seratus lima puluh satu milyar lima ratus empat puluh enam juta lima ratus enam puluh sembilan ribu lima ratus sembilan puluh rupiah), dalam perubahan terdapat kenaikan 64,93% atau sejumlah Rp 98.393.075.000,- (sembilan puluh delapan miliar tiga ratus sembilan puluh tiga juta tujuh puluh lima ribu rupiah) sehingga menjadi sejumlah Rp 249.939.644.590,- (dua ratus empat puluh sembilan miliar sembilan ratus tiga puluh sembilan juta enam ratus empat puluh empat ribu lima ratus sembilan puluh rupiah). Tidak disampaikan penjelasan rincian sumber PAD dari Pendapatan Transfer Antar Daerah itu dari mana saja.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (15, 'REKDPRD015', 'Dalam tabel 1.9 dan tabel 1.15 disampaikan Pendapatan Daerah sejumlah Rp 2.508.977.540.239,- (dua triliun lima ratus delapan miliar sembilan ratus tujuh puluh tujuh juta lima ratus empat puluh ribu dua ratus tiga puluh sembilan rupiah) serta pada tabel 1.10 dan tabel 1.16 disampaikan Belanja Daerah sejumlah Rp 2.616.828.521.954- (dua triliun enam ratus enam belas miliar delapan ratus dua puluh delapan juta lima ratus dua puluh satu juta sembilan ratus lima puluh empat rupiah). Ada perbedaan data dengan yang disampaikan pada uraian kondisi umum perubahan pembiayaan Tahun Anggaran 2024, yaitu anggaran pendapatan daerah sejumlah Rp 2.510.035.068.239,- (dua triliun lima ratus sepuluh milyar tiga puluh lima juta enam puluh delapan ribu dua ratus tiga puluh sembilan rupiah), dan anggaran belanja daerah sejumlah Rp 2.617.886.049.954,- (dua triliun enam ratus tujuh belas miliar delapan ratus delapan puluh enam juta empat puluh sembilan ribu sembilan ratus lima puluh empat rupiah). Dari data yang berbeda tersebut, ada kesamaan untuk penyampaian data defisit anggaran, yaitu sejumlah Rp 107.850.981.715,- (seratus tujuh milyar delapan ratus lima puluh juta sembilan ratus delapan puluh satu ribu tujuh ratus lima belas rupiah). Tidak ada penjelasan untuk sumber pembiayaan darimana saja, apakah SILPA terikat atau bebas dan kenapa terjadi perbedaan penyampaian jumlah pendapatan dan jumlah belanja dalam LKPJ Bupati Karanganyar Tahun Anggaran 2024.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (16, 'REKDPRD016', 'SILPA tahun 2024 wunaudited (indikatif) belum dilaporkan dalam dokumen LKPJ 2024, namun dengan perhitungan sendiri silpa tahun 2024 sebesar Rp.146.984.901.576,- (seratus empat puluh enam miliar sembilan ratus delapan puluh empat juta sembilan ratus satu ribu lima ratus tujuh puluh enam rupiah) secara nominal meningkat nilainya dibanding tahun sebelumnya.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (17, 'REKDPRD017', 'Proporsi SiLPA tahun 2024 sebesar 5,2% dari dana tersedia (besaran yang cukup ideal), secara nominal mengalami penurunan dibanding silpa tahun 2023 demikian juga proporsinya juga menurun. Data rincian Laporan silpa tahun berjalan 2024 (unaudited) berdasarkan obyek dan rincian obyek sumbernya, agar dapat diketahui sejak dini, berapa besaran silpa yang bebas dimanfaatkan untuk perubahan APBD tahun 2024, dan berapa besaran silpa tahun berjalan yang sudah terikat penggunaannya, apakah SiLPA tahun 2024 cukup untukmenutup defisit APBD tahun 2025?, berapa target SiLPA tahun 2025 dalam pembiayaan daerah APBD Kabupaten Karanganyar tahun 2025?', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (18, 'REKDPRD018', 'Selama tahun 2024 adakah perubahan Penjabaran APBD 2024 berdasarkan Peraturan Bupati (diluar Perubahan berdasarkan peraturan daerah), jika ada berapa kali Perubahan sepajang tahun 2024 tersebut dan apa dasar/regulasi yang memerintahkannya?. Dokumen LKPJ 2024 tidak menyajikan data tersebut, seharusnya data perubahan APBD baik yang berdasarkan perkada maupun Perda di sajikan secara lengkap dalam Bab II LKPJ.', 2024, NULL, 'Bagian Hukum SETDA', NULL, NULL, NULL, 'Bagian Hukum SETDA');
INSERT INTO `tb_rekomendasi_dprd` VALUES (19, 'REKDPRD019', 'Progres penyelesaian piutang daerah netto (setelah dikurangi piutang macet) sesuai neraca tahun 2023 sebesar Rp.46.567.970.025,64 (empat puluh enam miliar lima ratus enam puluh tujuh juta sembilan ratus tujuh puluh ribu dua puluh lima koma enam puluh empat rupiah) meningkat jumlahnya jika dibanding dengan saldo piutang pada tahun 2022 yang masih sebesar Rp.32.309.640.210,12 (tiga puluh dua miliar tiga ratus sembilan juta enam ratus empat puluh ribu dua ratus sepuluh koma dua belas rupiah) sedang piutang macet Rp. 39.777.657.744,35 (tiga puluh sembilan miliar tujuh ratus tujuh puluh tujuh juta enam ratus lima puluh tujuh ribu tujuh ratus empat puluh empat koma tiga puluh lima rupiah. Sampai dengan akhir tahun 2024, belum disampaikan progres penyelesaian berbagai piutang dan piutang macet tahun 2023 tersebut dan berapa piutang yang dapat ditarik Kembali dan masuk ke kas daerah selama tahun 2024.', 2024, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd` VALUES (20, 'REKDPRD020', 'Masih terdapat data capaian kinerja yang belum sesuai dengan target yang ditetapkan tahun 2024, yaitu :', 2024, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd` VALUES (21, 'REKDPRD021', 'Masih terdapat data capaian kinerja pembangunan yang belum lengkap tahun 2024, yaitu :', 2024, NULL, NULL, NULL, NULL, NULL, 'DPUPR');
INSERT INTO `tb_rekomendasi_dprd` VALUES (22, 'REKDPRD022', 'Hilirisasi sektor unggulan terutama sektor pertanian, pariwisata dan industri pengolahan dan pengembangan infrastruktur yang mendukung pertumbuhan sektor sektor tersebut.', 2024, NULL, 'DISPERTAN PP', NULL, NULL, NULL, 'DISPERTAN PP');
INSERT INTO `tb_rekomendasi_dprd` VALUES (23, 'REKDPRD023', 'Memastikan beberapa tema atau isu Pembangunan yang menjadi prioritas nasional kegiatan dan sub kegiatannya teragendakan dalam Perubahan APBD 2025 antara lain :', 2024, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd` VALUES (24, 'REKDPRD024', 'Pengembangan industri kerajinan dan memfasilitasi dalam mempromosikan dan memasarkan hasil industri kerajinan Usaha Mikro, Kecil dan Menengah (UMKM) serta mempermudah dalam perijinan-perijinannya.', 2024, NULL, 'DISKUKTRANS ESDM', NULL, NULL, NULL, 'DISKUKTRANS ESDM');
INSERT INTO `tb_rekomendasi_dprd` VALUES (25, 'REKDPRD025', 'Pengendalian pertumbuhan pasar/toko modern diluar daerah yang ditentukan peraturan daerah, agar lebih memberdayaan toko/warung tradisional.', 2024, NULL, 'DPMPTSP', NULL, NULL, NULL, 'DPMPTSP');
INSERT INTO `tb_rekomendasi_dprd` VALUES (26, 'REKDPRD026', 'Penguatan kebijakan dan daya dukung perekonomian inklusif yang fokus pada penguatan kelembagaan (Capacity Building) didukung inovasi, transformasi digital yang mendukung perindustrian, perdagangan, Pertanian perkebunan Perikanan pariwisata perkotaan (Urban Tourism) dan berpihak kepada Industri Kecil, Koperasi, Usaha Mikro serta Ekonomi Kreatif.', 2024, NULL, 'DISKUKTRANS ESDM', NULL, NULL, NULL, 'DISKUKTRANS ESDM');
INSERT INTO `tb_rekomendasi_dprd` VALUES (27, 'REKDPRD027', 'Penataan regulasi dan kebijakan pendukung implementasi Ekonomi Hijau (Green Economy) mendukung Komitmen Sustainable Development Goals (SDGs) menuju Net / Zero Waste Industry serta implementasi riset dan pengembang Energi baru Terbarukan (EBT) sesuai kewenangan daerah.', 2024, NULL, 'BAPERLITBANG', NULL, NULL, NULL, 'BAPERLITBANG');
INSERT INTO `tb_rekomendasi_dprd` VALUES (28, 'REKDPRD028', 'Penguatan kebijakan ekonomi yang berorientasi pada perluasan akses ekonomi-spasial melalui pembentukan pusat-pusat pertumbuhan ekonomi baru (Growth Pole) yang dapat mendorong pengembangan perekonomian ditandai kemandirian Kawasan perdesaan.', 2024, NULL, 'BAPERLITBANG', NULL, NULL, NULL, 'BAPERLITBANG');
INSERT INTO `tb_rekomendasi_dprd` VALUES (29, 'REKDPRD029', 'Meningkatkan Kkerjasama antar daerah secara berkelanjutan dengan kabupaten/kota sekitar (Kawasan Solo Raya) sebagai penyangga perekonomian dan menjaga ketersedian barang kebutuhan pokok dan stabilitas harga.', 2024, NULL, 'PEREKONOMIAN', NULL, NULL, NULL, 'Bagian Perekonomian SETDA');
INSERT INTO `tb_rekomendasi_dprd` VALUES (30, 'REKDPRD030', 'Meningkatkan integrasi dan transformasi teknologi dalam peningkatan produktivitas Pertanian, Perkebunan, Perikanan, Perdagangan dan Industri Pengolahan (termasuk industri mikro dan kecil).', 2024, NULL, 'DISPERTAN PP', NULL, NULL, NULL, 'DISPERTAN PP');
INSERT INTO `tb_rekomendasi_dprd` VALUES (31, 'REKDPRD031', 'Meningkatkan kualitas sarana prasarana berbasis smartcity yang inklusif, integratif, dan berkelanjutan dalam mendorong transformasi pembangunan.', 2024, NULL, 'DISKOMINFO', NULL, NULL, NULL, 'DISKOMINFO');
INSERT INTO `tb_rekomendasi_dprd` VALUES (32, 'REKDPRD032', 'Meningkatkan pengendalian pembangunan yang merata dan berkesinambungan melalui penerapan manajemen risiko.', 2024, NULL, 'BAPERLITBANG', NULL, NULL, NULL, 'BAPERLITBANG');
INSERT INTO `tb_rekomendasi_dprd` VALUES (33, 'REKDPRD033', 'Meningkatkan pembangunan infrastruktur transportasi yang efisien dan terintegrasi secara merata.', 2024, NULL, 'DPUPR', NULL, NULL, NULL, 'DPUPR');
INSERT INTO `tb_rekomendasi_dprd` VALUES (34, 'REKDPRD034', 'Peningkatan kualitas dan produktivitas tenaga kerja sehingga layak di bayar diatas UMR.', 2024, NULL, 'DISDAGPERINAKER', NULL, NULL, NULL, 'DISDAGPERINAKER');
INSERT INTO `tb_rekomendasi_dprd` VALUES (35, 'REKDPRD035', 'Penguatan inovasi pelayanan publik yang modern dan inovatif berbasis digital pada seluruh aspek pembangunan mendukung atmosfir industri, perdagangan dan pertanian, peternakan dan perikanan di Karanganyar.', 2024, NULL, 'DISPERTAN PP', NULL, NULL, NULL, 'DISPERTAN PP');
INSERT INTO `tb_rekomendasi_dprd` VALUES (36, 'REKDPRD036', 'Penegakan peraturan daerah dilaksanakan dengan tegas dan humanis mendukung tertib hukum dan kondusivitas daerah.', 2024, NULL, 'SATPOL PP', NULL, NULL, NULL, 'SATPOL PP');
INSERT INTO `tb_rekomendasi_dprd` VALUES (37, 'REKDPRD037', 'Penegakan peraturan daerah dilaksanakan dengan tegas dan humanis mendukung tertib hukum dan kondusivitas daerah.', 2024, NULL, 'SATPOL PP', NULL, NULL, NULL, 'SATPOL PP');
INSERT INTO `tb_rekomendasi_dprd` VALUES (38, 'REKDPRD038', 'Mempercepat pengentasan kemiskinan berbasis wilayah/ kecamatan/ Desa/kelurahan.', 2024, NULL, 'BAPERLITBANG', NULL, NULL, NULL, 'BAPERLITBANG');
INSERT INTO `tb_rekomendasi_dprd` VALUES (39, 'REKDPRD039', 'Meningkatkan Pembangunan ekonomi berbasis pertanian, perkebunan, perikanan, UMKM dan pariwisata dan ekonomi kreatif.', 2024, NULL, 'DISPERTAN PP', NULL, NULL, NULL, 'DISPERTAN PP');
INSERT INTO `tb_rekomendasi_dprd` VALUES (40, 'REKDPRD040', 'Meningkatkan jaring sosial pendidikan, kesehatan, pelayanan sosial, dan perlindungan tenaga kerja yang merata.', 2024, NULL, 'DISDIKBUD', NULL, NULL, NULL, 'DISDIKBUD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (41, 'REKDPRD041', 'Meningkatkan pembinaan profesional, peningkatan fasilitasi, dan pemberian insentif yang berkelanjutan dan merata.', 2024, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd` VALUES (42, 'REKDPRD042', 'Meningkatkan jaring sosial pendidikan bagi disabilitas, Masyarakat berprestasi, dan masyarakat marginal/rentan.', 2024, NULL, 'DISDIKBUD', NULL, NULL, NULL, 'DISDIKBUD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (43, 'REKDPRD043', 'Penanganan dampak bencana alam, layanan kedaruratan perlu ditingkatkan agar cepat merespon apabila terdapat kejadian bencana, tempat-tempat pariwisata perlu didukung sarana prasarana penanganan kedaruratan.', 2024, NULL, 'BPBD', NULL, NULL, NULL, 'BPBD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (44, 'REKDPRD044', 'Penguatan fondasi sistem pembangunan SDM melalui Pendidikan dan Kesehatan yang maju guna menjamin akses dan pelayanan Pendidikan dan kesehatan yang berdaya saing regional, nasional dan global.', 2024, NULL, 'DISDIKBUD', NULL, NULL, NULL, 'DISDIKBUD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (45, 'REKDPRD045', 'Pendidikan karakter religius-berakhlak pada SDM Masyarakat secara terintegrasi melalui pendidikan formal, non formal dan Pendidikan dalam keluarga.', 2024, NULL, 'DISDIKBUD', NULL, NULL, NULL, 'DISDIKBUD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (46, 'REKDPRD046', 'Meningkatkan kualitas pelayanan dasar guna menciptakan individu yang berdaya saing global, kapabel, adaptif, sehat, dan produktif.', 2024, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd` VALUES (47, 'REKDPRD047', 'Meningkatkan jaringan dan kesadaran inisiatif lokal dalam meningkatkan solidaritas sosial dalam masyarakat yang inklusif.', 2024, NULL, 'BAKESBANGPOL', NULL, NULL, NULL, 'BAKESBANGPOL');
INSERT INTO `tb_rekomendasi_dprd` VALUES (48, 'REKDPRD048', 'Meningkatkan ketahanan keluarga melalui pembentukan karakter masyarakat dengan ekspresi nilai-nilai agama, keluarga, dan kearifan lokal sebagai manifestasi masyarakat yang inklusif.', 2024, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd` VALUES (49, 'REKDPRD049', 'Penguatan kualitas dan kapabilitas kesehatan ibu, anak dan remaja melalui pendekatan terpadu berbasis kearifan lokal.', 2024, NULL, 'DINKES', NULL, NULL, NULL, 'DINKES');
INSERT INTO `tb_rekomendasi_dprd` VALUES (50, 'REKDPRD050', 'Meningkatkan kualitas Kesehatan, antara lain memberikan imunisasi lengkap, peningkatan gizi dan stunting untuk mengurangi AKI dan AKB, pencegahan prevalensi TBC, peningkatan fasilitas pelayanan kesehatan guna mengurangi lama antrian mendapatkan kamar rawat inap utamanya di Instalasi Gawat Darurat.', 2024, NULL, 'DINKES', NULL, NULL, NULL, 'DINKES');
INSERT INTO `tb_rekomendasi_dprd` VALUES (51, 'REKDPRD051', 'Penguatan kualitas, kompetensi, dan kapabilitas tenaga Kesehatan berstandar nasional dan internasional.', 2024, NULL, 'DINKES', NULL, NULL, NULL, 'DINKES');
INSERT INTO `tb_rekomendasi_dprd` VALUES (52, 'REKDPRD052', 'Meningkatkan kualitas pendidikan yang merata berstandar global (nasional/internasional). Peningkatan SDM Guru maupun Tenaga Non Guru agar dapat bersaing secara kualitas dengan sekolah swasta. Jangan sampai terdapat lagi Sekolah Negeri tidak mendapatkan atau kekurangan murid.', 2024, NULL, 'DISDIKBUD', NULL, NULL, NULL, 'DISDIKBUD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (53, 'REKDPRD053', 'Meningkatkan jaring sosial pendidikan bagi penyandang disabilitas, kelompok masyarakat rentan/ marginal dan berprestasi.', 2024, NULL, 'DISDIKBUD', NULL, NULL, NULL, 'DISDIKBUD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (54, 'REKDPRD054', 'Peningkatan pembinaan prestasi olahraga, antara lain dengan mempertimbangkan pendirian Sekolah Khusus Olahraga (SKO) dan Kelas Khusus Olahraga (KKO).', 2024, NULL, 'DISDIKBUD', NULL, NULL, NULL, 'DISDIKBUD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (55, 'REKDPRD055', 'Perlunya pemantapan capaian peta jalan (roadmap) Reformasi Birokrasi berdasarkan Permenpan RB Nomor 03 Tahun 2023 dengan terpenuhinya 21 indikator reformasi birokrasi general dan lima (5) Reformasi Birokrasi Tematik.', 2024, NULL, 'ORGANISASI', NULL, NULL, NULL, 'Bagian Organisasi SETDA');
INSERT INTO `tb_rekomendasi_dprd` VALUES (56, 'REKDPRD056', 'Terkait Data Kebutuhan ASN perlu disajikan pula uraian kondisi kebutuhan ASN pada masing-masing Organisasi Perangkat Daera%l (OPD) sesuai Peraturan Daerah maupun Peraturan Bupati terkait Pembentukan dan Susunan Perangkat Daerah Kabupaten Karanganyar karena data tersebut dapat memberikan informasi apakah jumlah tersebut sudah terpenuhi atau masih ada kekosongan/kekurangan jabatan ASN di masing-masing OPD. Apabila uraian tersebut tidak disajikan dapat menyebabkan pelayanan kepada masyarakat menjadi tidak optimal.', 2024, NULL, 'BKPSDM', NULL, NULL, NULL, 'BKPSDM');
INSERT INTO `tb_rekomendasi_dprd` VALUES (57, 'REKDPRD057', 'Penguatan berbagai daya dukung meningkatan kualitas tatakelola pemerintahan yang bersih dan adaptif didukung pengembangan Electronic Government (SPBE) terintegrasi.', 2024, NULL, 'INSPEKTORAT', NULL, NULL, NULL, 'INSPEKTORAT');
INSERT INTO `tb_rekomendasi_dprd` VALUES (58, 'REKDPRD058', 'Penguatan kapasitas ASN melalui perwujudan budaya birokrasi yang gesit dalam menghadapi ketidak stabilan, ketidakpastian, kompleksitas, dan ambiguitas.', 2024, NULL, 'BKPSDM', NULL, NULL, NULL, 'BKPSDM');
INSERT INTO `tb_rekomendasi_dprd` VALUES (59, 'REKDPRD059', 'Terkait dengan tingginya penerimaan retribusi daerah pada Tahun Anggaran 2024 sekitar 2.220,49% (dua ribu dua ratus dua puluh ribu koma empat puluh sembilan persen) agar disampaikan data terkait sumber kenaikannya darimana saja, sehingga dapat menjadi dasar lembaga DPRD untuk melakukan pengawasan dan evaluasi secara rutin.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (60, 'REKDPRD060', 'Terkait adanya pengurangan 94,48% dari Pendapatan Asli Daerah (PAD) dalamn LKPJ, agar disampaikan penjelasan rincian sumber PAD itu darimana sajadan alasan turun/pengurangan.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (61, 'REKDPRD061', 'Terkait penyajian data angka pendapatan dan belanja daerah, baik dalam tabel maupun narasi harus dilakukan secara cermat sehingga tidak terjadi perbedaan penyampaianjumlah pendapatan dan jumlah belanja dalam LKPJ Bupati Karanganyar.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (62, 'REKDPRD062', 'Berdasarkan Laporan Realisasi Anggaran APBD 2024 dan terbitnya Inpres nomor 1 tahun 2025 tentang efesiensi APBN dan APBD tahun 2025 yang ditindaklanjuti dengan keluarnya SE Mendagri nomor 900.1.1/640/SJ tertanggal 11 Februari 2025, Kabupaten Karanganyar harus merevisi perda APBD tahun 2025 agar dana tersedia tahun 2025 realistis sesuai kemampuan keuangan daerah dan menyesuaikan program kerja yang lebih substantial dan selaras dengan Visi Misi Bupati dan Wakil Bupati Terpilih serta Asta Cita Presiden Dan Wakil Presiden ke dalam Perubahan RKPD Kabupaten Karanganyar Tahun 2025 dan Perubahan APBD Tahun 2025.', 2024, NULL, 'SATPOL PP', NULL, NULL, NULL, 'BKD');
INSERT INTO `tb_rekomendasi_dprd` VALUES (63, 'REKDPRD063', 'Berdasarkan Laporan Realisasi Anggaran APBD 2024 dan terbitnya Inpres nomor 1 tahun 2025 tentang efesiensi APBN dan APBD tahun 2025 yang ditindaklanjuti dengan keluarnya SE Mendagri nomor 900.1.1/640/SJ tertanggal 11 Februari 2025, Kabupaten Karanganyar harus merevisi perda APBD tahun 2025 agar dana tersedia tahun 2025 realistis sesuai kemampuan keuangan daerah dan menyesuaikan program kerja yang lebih substantial dan selaras dengan Visi Misi Bupati dan Wakil Bupati Terpilih serta Asta Cita Presiden Dan Wakil Presiden ke dalam Perubahan RKPD Kabupaten Karanganyar Tahun 2025 dan Perubahan APBD Tahun 2025.', 2024, NULL, 'BKD', NULL, NULL, NULL, 'BKD');

-- ----------------------------
-- Table structure for tb_rekomendasi_dprd_opd
-- ----------------------------
DROP TABLE IF EXISTS `tb_rekomendasi_dprd_opd`;
CREATE TABLE `tb_rekomendasi_dprd_opd`  (
  `No` int NULL DEFAULT NULL,
  `KodeRekomendasiDPRD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TindakLanjut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `OPDPengampu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NamaOPDPengampu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Tahun` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_rekomendasi_dprd_opd
-- ----------------------------
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (1, 'REKDPRD001', NULL, 'BAPERLITBANG', 'BAPERLITBANG', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (2, 'REKDPRD002', NULL, 'PEMERINTAHAN', 'Sekretariat LKPJ', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (3, 'REKDPRD003', NULL, 'BAPERLITBANG', 'BAPERLITBANG', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (4, 'REKDPRD004', NULL, 'PEMERINTAHAN', 'Sekretariat LKPJ', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (5, 'REKDPRD005', NULL, 'PEMERINTAHAN', 'Sekretariat LKPJ', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (6, 'REKDPRD006', NULL, 'PEMERINTAHAN', 'Sekretariat LKPJ', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (7, 'REKDPRD007', NULL, 'PEMERINTAHAN', 'Sekretariat LKPJ', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (8, 'REKDPRD008', NULL, 'PEMERINTAHAN', 'Sekretariat LKPJ, Karanganyar dalam angka', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (9, 'REKDPRD009', NULL, 'PEMERINTAHAN', 'Sekretariat LKPJ', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (10, 'REKDPRD010', NULL, 'PEMERINTAHAN', 'Sekretariat LKPJ', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD010', NULL, 'DISDUKCAPIL', 'DISDUKCAPIL', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (11, 'REKDPRD011', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (12, 'REKDPRD012', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (13, 'REKDPRD013', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (14, 'REKDPRD014', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (15, 'REKDPRD015', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (16, 'REKDPRD016', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (17, 'REKDPRD017', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (18, 'REKDPRD018', NULL, 'HUKUM', 'Bagian Hukum SETDA', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (19, 'REKDPRD019', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (20, 'REKDPRD020', NULL, NULL, NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (21, 'REKDPRD021', NULL, NULL, '', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (22, 'REKDPRD022', NULL, 'DISPERTAN PP', 'DISPERTAN PP', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD022', NULL, 'DISPARPORA', 'DISPARPORA', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD022', NULL, 'DISDAGPERINAKER', 'DISDAGPERINAKER', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD022', NULL, 'DPUPR', 'DPUPR', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (23, 'REKDPRD023', NULL, NULL, NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (24, 'REKDPRD024', NULL, 'DISKUKTRANS ESDM', 'DISKUKTRANS ESDM', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (25, 'REKDPRD025', NULL, 'DPMPTSP', 'DPMPTSP', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (26, 'REKDPRD026', NULL, 'DISKUKTRANS ESDM', 'DISKUKTRANS ESDM', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD026', NULL, 'DISDAGPERINAKER', 'DISDAGPERINAKER', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (27, 'REKDPRD027', NULL, 'BAPERLITBANG', 'BAPERLITBANG', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (28, 'REKDPRD028', NULL, 'BAPERLITBANG', 'BAPERLITBANG', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (29, 'REKDPRD029', NULL, 'PEREKONOMIAN', 'Bagian Perekonomian SETDA', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD029', NULL, 'DISPERTAN PP', 'DISPERTAN PP', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD029', NULL, 'DISDAGPERINAKER', 'DISDAGPERINAKER', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (30, 'REKDPRD030', NULL, 'DISPERTAN PP', 'DISPERTAN PP', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD030', NULL, 'DISDAGPERINAKER', 'DISDAGPERINAKER', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (31, 'REKDPRD031', NULL, 'DISKOMINFO', 'DISKOMINFO', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (32, 'REKDPRD032', NULL, 'BAPERLITBANG', 'BAPERLITBANG', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (33, 'REKDPRD033', NULL, 'DPUPR', 'DPUPR', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (34, 'REKDPRD034', NULL, 'DISDAGPERINAKER', 'DISDAGPERINAKER', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (35, 'REKDPRD035', NULL, 'DISPERTAN PP', 'DISPERTAN PP', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD035', NULL, 'DISDAGPERINAKER', 'DISDAGPERINAKER', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (36, 'REKDPRD036', NULL, 'SATPOL PP', 'SATPOL PP', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (37, 'REKDPRD037', NULL, 'SATPOL PP', 'SATPOL PP', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (38, 'REKDPRD038', NULL, 'BAPERLITBANG', 'BAPERLITBANG', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (39, 'REKDPRD039', NULL, 'DISPERTAN PP', 'DISPERTAN PP', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, NULL, NULL, 'DISPARPORA', 'DISPARPORA', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (40, 'REKDPRD040', NULL, 'DISDIKBUD', 'DISDIKBUD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD040', NULL, 'DINKES', 'DINKES', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD040', NULL, 'DINSOS', 'DINSOS', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (41, 'REKDPRD041', NULL, 'DINSOS', 'DINSOS', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (42, 'REKDPRD042', NULL, 'DISDIKBUD', 'DISDIKBUD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (43, 'REKDPRD043', NULL, 'BPBD', 'BPBD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (44, 'REKDPRD044', NULL, 'DISDIKBUD', 'DISDIKBUD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD0', NULL, 'DINKES', 'DINKES', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (45, 'REKDPRD045', NULL, 'DISDIKBUD', 'DISDIKBUD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (46, 'REKDPRD046', NULL, 'DISDIKBUD', 'DISDIKBUD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (47, 'REKDPRD047', NULL, 'BAKESBANGPOL', 'BAKESBANGPOL', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (48, 'REKDPRD048', NULL, 'DISDIKBUD', 'DISDIKBUD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (49, 'REKDPRD049', NULL, 'DINKES', 'DINKES', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (50, 'REKDPRD050', NULL, 'DINKES', 'DINKES', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (51, 'REKDPRD051', NULL, 'DINKES', 'DINKES', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (52, 'REKDPRD052', NULL, 'DISDIKBUD', 'DISDIKBUD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (53, 'REKDPRD053', NULL, 'DISDIKBUD', 'DISDIKBUD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (54, 'REKDPRD054', NULL, 'DISDIKBUD', 'DISDIKBUD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (55, 'REKDPRD055', NULL, 'ORGANISASI', 'Bagian Organisasi SETDA', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (56, 'REKDPRD056', NULL, 'BKPSDM', 'BKPSDM', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (57, 'REKDPRD057', NULL, 'INSPEKTORAT', 'INSPEKTORAT', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (58, 'REKDPRD058', NULL, 'BKPSDM', 'BKPSDM', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (59, 'REKDPRD059', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (60, 'REKDPRD060', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (61, 'REKDPRD061', NULL, 'BKD', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (62, 'REKDPRD062', NULL, 'SATPOL PP', 'BKD', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (NULL, 'REKDPRD062', NULL, 'BAPERLITBANG', 'BAPERLITBANG', 2024);
INSERT INTO `tb_rekomendasi_dprd_opd` VALUES (63, 'REKDPRD063', NULL, 'BKD', 'BKD', 2024);

-- ----------------------------
-- Table structure for tb_rekomendasi_dprd_sub
-- ----------------------------
DROP TABLE IF EXISTS `tb_rekomendasi_dprd_sub`;
CREATE TABLE `tb_rekomendasi_dprd_sub`  (
  `No` int NULL DEFAULT NULL,
  `KodeRekomendasiDPRD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `KodeSubRekomendasiDPRD` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `OPDPengampu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NamaOPDPengampu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SubRekomendasiDPRD` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TindakLanjut` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Tahun` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_rekomendasi_dprd_sub
-- ----------------------------
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD007', 'DPRD007S001', 'PEMERINTAHAN', 'Sekretariat LKPJ', 'a. Undang-Undang Nomor 20 Tahun 2023 tentang Aparatur Sipil Negara (ASN);', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD007', 'DPRD007S002', 'PEMERINTAHAN', 'Sekretariat LKPJ', 'b. Peraturan Pemerintah Nomor 11 Tahun 2017 tentang Manajemen Pegawai Negeri Sipil sebagaimana diubah dengan Peraturan Pemerintah No. 17 Tahun 2020;', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD007', 'DPRD007S003', 'PEMERINTAHAN', 'Sekretariat LKPJ', 'c. Peraturan Menteri Dalam Negeri Republik Indonesia Nomor 4 Tahun 2023 tentang Penjabat Gubernur, Penjabat Bupati, dan Penjabat Wali Kota.', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD020', 'DPRD020S001', 'BKD', 'BKD', 'a.    Persentase kawasan pemukiman kumuh dibawah 10 ha di kabupaten/ kota yang ditangani;', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD020', 'DPRD020S002', 'DPUPR', 'DPUPR', 'b.    Persentase cakupan layanan air minum (perpipaan);', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD020', 'DPRD020S003', 'BPBD', 'BPBD', 'c.    Persentase desa/kelurahan tangguh bencana;', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD020', 'DPRD020S004', 'SATPOL PP', 'SATPOL PP', 'd.    Persentasi Perda dan Perkada yang ditegakkan;', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD020', 'DPRD020S005', 'DISDAGPERINAKER', 'DISDAGPERINAKER', 'e.    Persentase tenaga kerja bersertifikasi kompetensi;', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD020', 'DPRD020S006', 'DP3APPKB', 'DP3APPKB', 'f.     Persentase kebutuhan ber KB yang tidak terpenuhi (unmet need);', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD020', 'DPRD020S007', 'DISKUKTRANS ESDM', 'DISKUKTRANS ESDM', 'g.    Persentase pertumbuhan usaha mikro;', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD020', 'DPRD020S008', 'DISDAGPERINAKER', 'DISDAGPERINAKER', 'h.    Persentase pemenuhan standardisasi SNI secara bertahap.', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD021', 'DPRD021S001', 'DISDAGPERINAKER', 'DISDAGPERINAKER', 'a.    Persentase luas daerah irigasi berdasarkan kewenangan kabupaten yang dilayani;', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD021', 'DPRD021S002', 'DPUPR', 'DPUPR', 'b.    Persentase kawasan kumuh;', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD021', 'DPRD021S003', 'DPUPR', 'DPUPR', 'c.    Persentase penanganan rumah tidak layak huni (RTLH);', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD021', 'DPRD021S004', 'DISDAGPERINAKER', 'DISDAGPERINAKER', 'd.    Persentase usaha mikro yang dibina;', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD021', 'DPRD021S005', 'DISDAGPERINAKER', 'DISDAGPERINAKER', 'e.    Jumlah sentra industri mikro yang dibentuk.', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD023', 'DPRD023S001', 'DISDIKBUD', 'DISDIKBUD', 'a.    Penguatan Sumber daya Manusia Pendidikan dan Kesehatan;', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD023', 'DPRD023S002', 'DINKES', 'DINKES', 'b.    Program makan bergizi Gratis (MBG);', NULL, 2024);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD023', 'DPRD023S003', 'BAPERLITBANG', 'BAPERLITBANG', 'c.    Pencegahan stunting dan kemiskinan ekstrim;', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD023', 'DPRD023S004', 'PEREKONOMIAN', 'Bagian Perekonomian SETDA', 'd.    Pengendalian inflasi di daerah;', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD023', 'DPRD023S005', 'DISPERTAN PP', 'DISPERTAN PP', 'e.    Peningkatan pertumbuhan perekonomian daerah;', NULL, NULL);
INSERT INTO `tb_rekomendasi_dprd_sub` VALUES (NULL, 'REKDPRD023', 'DPRD023S006', 'DISPERTAN PP', 'DISPERTAN PP', 'f.     Dukungan swasembada Pangan.', NULL, NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp(0) NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `opd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (2, 'PEMERINTAHAN', 'pemerintahan@gmail.com', NULL, '$2y$12$0l7ovhDJmFuE5UroXvI2RuriLLxrubrts/3a2rCvy8SUVThUjoPPu', NULL, '2025-07-28 01:26:50', '2025-07-28 01:26:50', 'PEMERINTAHAN');
INSERT INTO `users` VALUES (3, 'BKD', 'bkd@gmail.com', NULL, '$2y$12$G13oSC6L0SKlvaHvWfizdevyLWTS0pg96nU9bUnUcnXBM7.Q9gClu', NULL, '2025-07-30 03:10:57', '2025-07-30 03:10:57', 'BKD');
INSERT INTO `users` VALUES (4, 'HUKUM', 'hukum@gmail.com', NULL, '$2y$12$L1xMRvigiJeYr31Ow1jwVuYf/Agj7kMWm34OgpaeRyshZmotysEBm', NULL, '2025-07-30 03:49:00', '2025-07-30 03:49:00', 'HUKUM');
INSERT INTO `users` VALUES (5, 'ORGANISASI', 'organisasi@gmail.com', NULL, '$2y$12$nTv0t/OQVGYSJHHyjEflweuJIW4aVIlSBs8AetgafNrUX0RX8.Om6', NULL, '2025-07-30 04:24:31', '2025-07-30 04:24:31', 'ORGANISASI');
INSERT INTO `users` VALUES (6, 'BKPSDM', 'bkpsdm@gmail.com', NULL, '$2y$12$c8cph0jYaD0l96ab3xDkbOh5/lFD8mdkooSSSYKaSVTF8Of3NSyJ.', NULL, '2025-07-30 04:27:03', '2025-07-30 04:27:03', 'BKPSDM');
INSERT INTO `users` VALUES (7, 'DINKES', 'dinkes@gmail.com', NULL, '$2y$12$DwmUMYuAGlPC1hheTw3WOOJU8Gt2yIhWnuZuks3igCcDbS8aQbqpq', NULL, '2025-07-30 04:27:58', '2025-07-30 04:27:58', 'DINKES');
INSERT INTO `users` VALUES (8, 'DPMPTSP', 'dpmptsp@gmail.com', NULL, '$2y$12$tNOgdwVAT2tzkkaWRb003Ot3Iec9/H.ivOKw9PHHrp7hJ3g6Xth4W', NULL, '2025-07-30 04:28:54', '2025-07-30 04:28:54', 'DPMPTSP');
INSERT INTO `users` VALUES (9, 'INSPEKTORAT', 'inspektorat@gmail.com', NULL, '$2y$12$K5XtOdxuJRcwRZ0CVpIC4eXsduiv8GSkkhHGUseMGRvTSsfDi8FqG', NULL, '2025-07-30 04:29:45', '2025-07-30 04:29:45', 'INSPEKTORAT');
INSERT INTO `users` VALUES (10, 'SATPOL PP', 'kesbangpol/satpolpp@gmail.com', NULL, '$2y$12$.dkrGokpMfapl/HHRPfvR.k6bDNtOBlE34PZ0L/9ieruCfK7nSHd6', NULL, '2025-07-30 04:30:53', '2025-07-30 04:30:53', 'KESBANGPOL/SATPOL PP');
INSERT INTO `users` VALUES (11, 'DISDUKCAPIL', 'disdukcapil@gmial.com', NULL, '$2y$12$Dt0EQtqXLGY3epf7HbRIoOBufCd2flTBwfuLFQ4wizMgsODQ4kEte', NULL, '2025-08-12 02:03:43', '2025-08-12 02:03:43', 'DISDUKCAPIL');
INSERT INTO `users` VALUES (12, 'DPUPR', 'dpupr@gmial.com', NULL, '$2y$12$jr7itKqrUWowF6fts/S2uOIEXyGMWY/EeWDuchQsclTRZVi5f2tOC', NULL, '2025-08-12 02:20:24', '2025-08-12 02:20:24', 'DPUPR');
INSERT INTO `users` VALUES (13, 'BPBD', 'bpbd@gmail.com', NULL, '$2y$12$Nq1jLm.mNypCR6hPqxQOzuANncsbklchWwB8y0odfz11qXGf9gB5i', NULL, '2025-08-12 02:21:43', '2025-08-12 02:21:43', 'BPBD');
INSERT INTO `users` VALUES (14, 'DISDAGPERINAKER', 'disdagperinaker@gmail.com', NULL, '$2y$12$mhYn51T2R2Wo4LZXAwQU7uvWc1Z6zn70ufkCFNkUcJhWmC5fD.ewe', NULL, '2025-08-12 02:22:41', '2025-08-12 02:22:41', 'DISDAGPERINAKER');
INSERT INTO `users` VALUES (15, 'DP3APPKB', 'dp3appkb@gmail.com', NULL, '$2y$12$pvAziHvQ42VDfqjyyG3ZlOQ7/5uaFwuM6dlCpmiMUHmprI9KreEnS', NULL, '2025-08-12 02:23:27', '2025-08-12 02:23:27', 'DP3APPKB');
INSERT INTO `users` VALUES (16, 'DISKUKTRANS ESDM', 'diskuktransesdm@gmail.com', NULL, '$2y$12$5n2g4QXw4LKwk412SR6fvevdl3aEvHU9qY.VqDw2MgbBCnJVR/Bd.', NULL, '2025-08-12 02:25:19', '2025-08-12 02:25:19', 'DISKUKTRANS ESDM');
INSERT INTO `users` VALUES (17, 'DISPARPORA', 'disparpora@gmail.com', NULL, '$2y$12$/o4OQB2HM8wdAG/iwzEPNOMQ.SdUps9awNESLfVYWk511Y3C1ajhK', NULL, '2025-08-12 02:26:00', '2025-08-12 02:26:00', 'DISPARPORA');
INSERT INTO `users` VALUES (18, 'DISDIKBUD', 'disdikbud@gmail.com', NULL, '$2y$12$liL2BB2O3pAh1qChvl40NeHT/qnOZRgdNBha69EYid2933SMETLa2', NULL, '2025-08-12 02:26:44', '2025-08-12 02:26:44', 'DISDIKBUD');
INSERT INTO `users` VALUES (19, 'BAPERLITBANG', 'baperlitbang@gmail.com', NULL, '$2y$12$NqRwkW.neFyN.Vk6pDBrw.Tqp5vk6Ix5KwD7R81xs.H1AtSAhnQVK', NULL, '2025-08-12 02:27:29', '2025-08-12 02:27:29', 'BAPERLITBANG');
INSERT INTO `users` VALUES (20, 'PEREKONOMIAN', 'perekonomian@gmail.com', NULL, '$2y$12$3VMVdGEUqRprEcGXuLcXnOm2uAlE.lDDAWjEjI27coDdKYiXonzXm', NULL, '2025-08-12 02:28:09', '2025-08-12 02:28:09', 'PEREKONOMIAN');
INSERT INTO `users` VALUES (21, 'DISPERTAN PP', 'dispertanpp@gmail.com', NULL, '$2y$12$etMcjr8jtR7Bb/dDsNJrHuXo1RHFC2c.FVCxr2ro09QIdctuXwEBq', NULL, '2025-08-12 02:29:19', '2025-08-12 02:29:19', 'DISPERTAN PP');
INSERT INTO `users` VALUES (22, 'DISKOMINFO', 'diskominfo@gmail.com', NULL, '$2y$12$xzXUXTFKhutwUN17.iS6SOQ7pQS3GW9JN7XHUWZHSDAewHKJ4Fpcq', NULL, '2025-08-12 02:29:57', '2025-08-12 02:29:57', 'DISKOMINFO');
INSERT INTO `users` VALUES (23, 'DINSOS', 'dinsos@gmail.com', NULL, '$2y$12$RDUBWi50Cst09gtT4Nw8F.yWtIHxaCD8JdKlHyJpZj1IM5kP6a07S', NULL, '2025-08-12 02:30:36', '2025-08-12 02:30:36', 'DINSOS');
INSERT INTO `users` VALUES (24, 'BAKESBANGPOL', 'bakesbangpol@gmail.com', NULL, '$2y$12$s9PK154NF6UzQDM60kmP/eaDDoEq.njJ833tfO85AzjzOrqGs9y0m', NULL, '2025-08-12 02:31:27', '2025-08-12 02:31:27', 'BAKESBANGPOL');

SET FOREIGN_KEY_CHECKS = 1;
