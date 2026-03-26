-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2026 at 04:41 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `edutrack`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `created_at`, `updated_at`) VALUES
(6, 'admin', '$2y$12$0hUbyWLaktKj8Fue/EVcqu2xV54AGZFWeWPkwPc590p5Ji7aDSUKq', '2026-03-26 08:33:00', '2026-03-26 08:33:39');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `code`, `title`, `description`, `created_at`, `updated_at`) VALUES
(6, 'CS101', 'Algoritma Dasar', 'Logika pemrograman dan flowchart', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(7, 'CS102', 'Pemrograman Web', 'Dasar HTML, CSS, JavaScript', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(8, 'CS201', 'Basis Data', 'SQL dan desain relasional', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(9, 'CS202', 'Pemrograman Berorientasi Objek', 'Class, inheritance, polymorphism', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(10, 'CS301', 'Rekayasa Perangkat Lunak', 'Analisis kebutuhan dan testing', '2026-03-26 08:22:33', '2026-03-26 08:22:33');

-- --------------------------------------------------------

--
-- Table structure for table `course_student`
--

CREATE TABLE `course_student` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `course_student`
--

INSERT INTO `course_student` (`id`, `student_id`, `course_id`, `created_at`, `updated_at`) VALUES
(2, 7, 6, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(3, 7, 7, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(4, 7, 8, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(5, 8, 7, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(6, 8, 8, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(7, 8, 9, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(8, 9, 8, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(9, 9, 9, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(10, 9, 10, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(11, 10, 6, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(12, 10, 7, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(13, 10, 8, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(14, 11, 7, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(15, 11, 8, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(16, 11, 9, '2026-03-26 08:22:33', '2026-03-26 08:22:33');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `scores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`scores`)),
  `feedback` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`feedback`)),
  `final_score` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`id`, `student_id`, `course_id`, `scores`, `feedback`, `final_score`, `created_at`, `updated_at`) VALUES
(3, 7, 6, '[75,81,86]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 80.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(4, 7, 7, '[76,82,87]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 81.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(5, 7, 8, '[77,83,88]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 82.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(6, 8, 7, '[77,83,88]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 82.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(7, 8, 8, '[78,84,89]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 83.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(8, 8, 9, '[79,85,90]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 84.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(9, 9, 8, '[79,85,90]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 84.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(10, 9, 9, '[80,86,91]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 85.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(11, 9, 10, '[81,87,92]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 86.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(12, 10, 6, '[78,84,89]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 83.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(13, 10, 7, '[79,85,90]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 84.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(14, 10, 8, '[80,86,91]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 85.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(15, 11, 7, '[80,86,91]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 85.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(16, 11, 8, '[81,87,92]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 86.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(17, 11, 9, '[72,78,83]', '[\"Performa stabil\",\"Pertahankan konsistensi\"]', 77.67, '2026-03-26 08:22:33', '2026-03-26 08:22:33');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_01_01_000000_create_students_table', 1),
(6, '2024_01_01_000001_create_courses_table', 1),
(7, '2024_01_01_000002_create_course_student_table', 1),
(8, '2024_01_01_000003_create_grades_table', 1),
(9, '2024_01_01_000004_create_submissions_table', 1),
(10, '2024_01_01_000005_create_admins_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_number` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `major` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `student_number`, `name`, `email`, `major`, `created_at`, `updated_at`) VALUES
(7, 'STU-001', 'Ari Saputra', 'ari@kampus.ac.id', 'Informatika', '2026-03-26 08:20:38', '2026-03-26 08:22:33'),
(8, 'STU-002', 'Bunga Lestari', 'bunga@kampus.ac.id', 'Sistem Informasi', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(9, 'STU-003', 'Cahyo Pratama', 'cahyo@kampus.ac.id', 'Teknik Komputer', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(10, 'STU-004', 'Dinda Maharani', 'dinda@kampus.ac.id', 'Informatika', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(11, 'STU-005', 'Eka Ramadhan', 'eka@kampus.ac.id', 'Sistem Informasi', '2026-03-26 08:22:33', '2026-03-26 08:22:33');

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE `submissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `student_id` bigint(20) UNSIGNED NOT NULL,
  `course_id` bigint(20) UNSIGNED NOT NULL,
  `task_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `original_file_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `submissions`
--

INSERT INTO `submissions` (`id`, `student_id`, `course_id`, `task_name`, `file_path`, `original_file_name`, `created_at`, `updated_at`) VALUES
(2, 7, 6, 'Tugas Demo STU-001', 'submissions/demo-stu-001.pdf', 'demo-stu-001.pdf', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(3, 8, 7, 'Tugas Demo STU-002', 'submissions/demo-stu-002.pdf', 'demo-stu-002.pdf', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(4, 9, 8, 'Tugas Demo STU-003', 'submissions/demo-stu-003.pdf', 'demo-stu-003.pdf', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(5, 10, 6, 'Tugas Demo STU-004', 'submissions/demo-stu-004.pdf', 'demo-stu-004.pdf', '2026-03-26 08:22:33', '2026-03-26 08:22:33'),
(6, 11, 7, 'Tugas Demo STU-005', 'submissions/demo-stu-005.pdf', 'demo-stu-005.pdf', '2026-03-26 08:22:33', '2026-03-26 08:22:33');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_username_unique` (`username`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courses_code_unique` (`code`);

--
-- Indexes for table `course_student`
--
ALTER TABLE `course_student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `course_student_student_id_course_id_unique` (`student_id`,`course_id`),
  ADD KEY `course_student_course_id_foreign` (`course_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `grades_student_id_course_id_unique` (`student_id`,`course_id`),
  ADD KEY `grades_course_id_foreign` (`course_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `students_student_number_unique` (`student_number`),
  ADD UNIQUE KEY `students_email_unique` (`email`);

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submissions_student_id_foreign` (`student_id`),
  ADD KEY `submissions_course_id_foreign` (`course_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `course_student`
--
ALTER TABLE `course_student`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `submissions`
--
ALTER TABLE `submissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `course_student`
--
ALTER TABLE `course_student`
  ADD CONSTRAINT `course_student_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `course_student_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `grades_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `grades_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `submissions_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submissions_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
