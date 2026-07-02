CREATE DATABASE  IF NOT EXISTS `autoservice` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `autoservice`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: autoservice
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '6769bc30-1c83-11f1-ba88-d843ae01a3ca:1-69';

--
-- Table structure for table `автомобили`
--

DROP TABLE IF EXISTS `автомобили`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `автомобили` (
  `id_автомобиля` int NOT NULL AUTO_INCREMENT,
  `id_клиента` int NOT NULL,
  `марка` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `модель` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `гос_номер` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vin` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `год_выпуска` year DEFAULT NULL,
  `пробег` int DEFAULT NULL,
  `комментарий` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_автомобиля`),
  UNIQUE KEY `гос_номер` (`гос_номер`),
  UNIQUE KEY `vin` (`vin`),
  KEY `id_клиента` (`id_клиента`),
  CONSTRAINT `автомобили_ibfk_1` FOREIGN KEY (`id_клиента`) REFERENCES `клиенты` (`id_клиента`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица автомобилей клиентов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `автомобили`
--

LOCK TABLES `автомобили` WRITE;
/*!40000 ALTER TABLE `автомобили` DISABLE KEYS */;
INSERT INTO `автомобили` VALUES (1,1,'Toyota','Camry','A123BB777','JTDBE32K123456789',2020,45000,NULL),(2,1,'Honda','CR-V','B456CC777','JHLRE485012345678',2019,67000,NULL),(3,2,'Lada','Vesta','E789KK777','XTAGFL11012345678',2022,15000,NULL),(4,3,'BMW','X5','M001MM777','WBAKS410201234567',2021,32000,NULL),(5,4,'Kia','Rio','P002PP777','Z94CB41AAR1234567',2023,8000,NULL),(6,5,'Ford','Focus','C003CC777','WF0UXXGAJU1234567',2018,89000,NULL);
/*!40000 ALTER TABLE `автомобили` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `заказы`
--

DROP TABLE IF EXISTS `заказы`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `заказы` (
  `id_заказа` int NOT NULL AUTO_INCREMENT,
  `id_автомобиля` int NOT NULL,
  `id_сотрудника` int NOT NULL,
  `дата_создания` datetime DEFAULT CURRENT_TIMESTAMP,
  `дата_выполнения` date DEFAULT NULL,
  `статус` enum('новый','в работе','ожидание запчастей','выполнен','отменен') COLLATE utf8mb4_unicode_ci DEFAULT 'новый',
  `проблема_описание` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `результат_работы` text COLLATE utf8mb4_unicode_ci,
  `сумма_услуг` decimal(10,2) DEFAULT '0.00',
  `сумма_запчастей` decimal(10,2) DEFAULT '0.00',
  `итоговая_сумма` decimal(10,2) DEFAULT '0.00',
  `комментарий` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_заказа`),
  KEY `id_автомобиля` (`id_автомобиля`),
  KEY `id_сотрудника` (`id_сотрудника`),
  CONSTRAINT `заказы_ibfk_1` FOREIGN KEY (`id_автомобиля`) REFERENCES `автомобили` (`id_автомобиля`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `заказы_ibfk_2` FOREIGN KEY (`id_сотрудника`) REFERENCES `сотрудники` (`id_сотрудника`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Заказы на ремонт и обслуживание';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `заказы`
--

LOCK TABLES `заказы` WRITE;
/*!40000 ALTER TABLE `заказы` DISABLE KEYS */;
INSERT INTO `заказы` VALUES (1,1,1,'2024-01-15 10:30:00',NULL,'выполнен','Плановое ТО: замена масла и фильтров','Заменены масло и фильтры',2000.00,4100.00,6100.00,NULL),(2,3,1,'2024-01-16 11:15:00',NULL,'выполнен','Стук в подвеске при движении','Заменены передние амортизаторы',1500.00,4500.00,6000.00,NULL),(3,2,2,'2024-01-17 09:45:00',NULL,'в работе','Замена тормозных колодок',NULL,2500.00,2500.00,5000.00,NULL),(4,4,3,'2024-01-18 14:20:00',NULL,'ожидание запчастей','Не заводится, стартер не крутит','Требуется замена стартера, деталь заказана',2000.00,0.00,2000.00,NULL),(5,5,1,'2024-01-19 12:00:00',NULL,'новый','Проверка кондиционера, не охлаждает',NULL,0.00,0.00,0.00,NULL);
/*!40000 ALTER TABLE `заказы` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `запчасти`
--

DROP TABLE IF EXISTS `запчасти`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `запчасти` (
  `id_запчасти` int NOT NULL AUTO_INCREMENT,
  `название` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `артикул` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `производитель` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `цена_закупки` decimal(10,2) DEFAULT NULL,
  `цена_продажи` decimal(10,2) NOT NULL,
  `количество_на_складе` int DEFAULT '0',
  `мин_количество` int DEFAULT '5',
  `местоположение` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `категория` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_запчасти`),
  UNIQUE KEY `артикул` (`артикул`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Склад запчастей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `запчасти`
--

LOCK TABLES `запчасти` WRITE;
/*!40000 ALTER TABLE `запчасти` DISABLE KEYS */;
INSERT INTO `запчасти` VALUES (1,'Масло моторное 5W-30 (4л)','OIL-5W30-4L','Shell',2500.00,3500.00,15,5,NULL,'Масла'),(2,'Фильтр масляный Toyota','FIL-TOY-001','JapanParts',300.00,600.00,20,5,NULL,'Фильтры'),(3,'Колодки тормозные передние','BRK-FRONT-001','Bosch',1500.00,2500.00,8,3,NULL,'Тормозная система'),(4,'Свеча зажигания','SPK-NGK-001','NGK',400.00,800.00,30,10,NULL,'Зажигание'),(5,'Ремень ГРМ','BELT-TIM-001','Gates',1800.00,2800.00,5,2,NULL,'Двигатель'),(6,'Фильтр воздушный','AIR-FIL-001','Fram',450.00,850.00,12,5,NULL,'Фильтры'),(7,'Антифриз (5л)','COOL-5L','Liqui Moly',1800.00,2800.00,7,3,NULL,'Жидкости'),(8,'Лампа головного света','LAMP-H7','Philips',350.00,650.00,25,10,NULL,'Электрика');
/*!40000 ALTER TABLE `запчасти` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `запчасти_заказа`
--

DROP TABLE IF EXISTS `запчасти_заказа`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `запчасти_заказа` (
  `id_запчасти_заказа` int NOT NULL AUTO_INCREMENT,
  `id_заказа` int NOT NULL,
  `id_запчасти` int NOT NULL,
  `количество` int NOT NULL DEFAULT '1',
  `цена_фиксированная` decimal(10,2) DEFAULT NULL,
  `комментарий` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_запчасти_заказа`),
  KEY `id_заказа` (`id_заказа`),
  KEY `id_запчасти` (`id_запчасти`),
  CONSTRAINT `запчасти_заказа_ibfk_1` FOREIGN KEY (`id_заказа`) REFERENCES `заказы` (`id_заказа`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `запчасти_заказа_ibfk_2` FOREIGN KEY (`id_запчасти`) REFERENCES `запчасти` (`id_запчасти`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Использованные запчасти в заказе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `запчасти_заказа`
--

LOCK TABLES `запчасти_заказа` WRITE;
/*!40000 ALTER TABLE `запчасти_заказа` DISABLE KEYS */;
INSERT INTO `запчасти_заказа` VALUES (1,1,1,1,3500.00,NULL),(2,1,2,1,600.00,NULL),(3,2,5,1,2800.00,NULL),(4,2,7,1,1700.00,NULL),(5,3,3,1,2500.00,NULL);
/*!40000 ALTER TABLE `запчасти_заказа` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `клиенты`
--

DROP TABLE IF EXISTS `клиенты`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `клиенты` (
  `id_клиента` int NOT NULL AUTO_INCREMENT,
  `фамилия` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `имя` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `отчество` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `телефон` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `адрес` text COLLATE utf8mb4_unicode_ci,
  `дата_регистрации` date DEFAULT (curdate()),
  `комментарий` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_клиента`),
  UNIQUE KEY `телефон` (`телефон`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица клиентов автосервиса';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `клиенты`
--

LOCK TABLES `клиенты` WRITE;
/*!40000 ALTER TABLE `клиенты` DISABLE KEYS */;
INSERT INTO `клиенты` VALUES (1,'Иванов','Иван','Иванович','79011234567','ivanov@mail.ru','г. Москва, ул. Ленина, 10-15','2026-03-17',NULL),(2,'Петров','Петр','Петрович','79022345678','petrov@mail.ru','г. Москва, ул. Гагарина, 5-20','2026-03-17',NULL),(3,'Сидоров','Сидр','Сидорович','79033456789','sidorov@mail.ru','г. Москва, ул. Пушкина, 3-7','2026-03-17',NULL),(4,'Козлова','Анна','Ивановна','79044567890','kozlova@mail.ru','г. Москва, ул. Тверская, 15-3','2026-03-17',NULL),(5,'Морозов','Дмитрий','Алексеевич','79055678901','morozov@mail.ru','г. Москва, ул. Арбат, 25-12','2026-03-17',NULL);
/*!40000 ALTER TABLE `клиенты` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `сотрудники`
--

DROP TABLE IF EXISTS `сотрудники`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `сотрудники` (
  `id_сотрудника` int NOT NULL AUTO_INCREMENT,
  `фамилия` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `имя` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `отчество` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `должность` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `телефон` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `дата_найма` date NOT NULL,
  `ставка_час` decimal(10,2) NOT NULL,
  `комментарий` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_сотрудника`),
  UNIQUE KEY `телефон` (`телефон`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица сотрудников автосервиса';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `сотрудники`
--

LOCK TABLES `сотрудники` WRITE;
/*!40000 ALTER TABLE `сотрудники` DISABLE KEYS */;
INSERT INTO `сотрудники` VALUES (1,'Смирнов','Алексей','Викторович','Мастер-приемщик','79061112233','smirnov@sto.ru','2020-01-15',500.00,NULL),(2,'Кузнецов','Андрей','Николаевич','Автомеханик','79062223344','kuznetsov@sto.ru','2021-03-20',400.00,NULL),(3,'Попов','Сергей','Васильевич','Автоэлектрик','79063334455','popov@sto.ru','2019-11-10',450.00,NULL),(4,'Васильев','Николай','Петрович','Мастер по ремонту ДВС','79064445566','vasiliev@sto.ru','2022-05-05',600.00,NULL),(5,'Новикова','Елена','Сергеевна','Администратор','79065556677','novikova@sto.ru','2023-01-10',400.00,NULL);
/*!40000 ALTER TABLE `сотрудники` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `услуги`
--

DROP TABLE IF EXISTS `услуги`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `услуги` (
  `id_услуги` int NOT NULL AUTO_INCREMENT,
  `название` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `описание` text COLLATE utf8mb4_unicode_ci,
  `стоимость` decimal(10,2) NOT NULL,
  `время_выполнения_мин` int DEFAULT NULL COMMENT 'Время в минутах',
  `категория` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `активна` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_услуги`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Прайс-лист услуг автосервиса';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `услуги`
--

LOCK TABLES `услуги` WRITE;
/*!40000 ALTER TABLE `услуги` DISABLE KEYS */;
INSERT INTO `услуги` VALUES (1,'Замена масла','Замена моторного масла и масляного фильтра',2000.00,60,'ТО',1),(2,'Диагностика подвески','Проверка состояния амортизаторов, рычагов, сайлентблоков',1500.00,45,'Диагностика',1),(3,'Замена тормозных колодок','Замена передних или задних тормозных колодок',2500.00,60,'Ремонт',1),(4,'Компьютерная диагностика','Сканирование электронных блоков автомобиля',2000.00,40,'Диагностика',1),(5,'Замена свечей зажигания','Замена комплекта свечей зажигания',1500.00,45,'ТО',1),(6,'Регулировка развал-схождения','Проверка и регулировка углов установки колес',2500.00,60,'Ремонт',1),(7,'Замена ремня ГРМ','Замена ремня газораспределительного механизма',5500.00,180,'Ремонт',1),(8,'Ремонт кондиционера','Диагностика и заправка кондиционера',3000.00,90,'Ремонт',1);
/*!40000 ALTER TABLE `услуги` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `услуги_заказа`
--

DROP TABLE IF EXISTS `услуги_заказа`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `услуги_заказа` (
  `id_услуги_заказа` int NOT NULL AUTO_INCREMENT,
  `id_заказа` int NOT NULL,
  `id_услуги` int NOT NULL,
  `id_сотрудника` int NOT NULL,
  `количество` int DEFAULT '1',
  `цена_фиксированная` decimal(10,2) DEFAULT NULL,
  `комментарий` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id_услуги_заказа`),
  KEY `id_заказа` (`id_заказа`),
  KEY `id_услуги` (`id_услуги`),
  KEY `id_сотрудника` (`id_сотрудника`),
  CONSTRAINT `услуги_заказа_ibfk_1` FOREIGN KEY (`id_заказа`) REFERENCES `заказы` (`id_заказа`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `услуги_заказа_ibfk_2` FOREIGN KEY (`id_услуги`) REFERENCES `услуги` (`id_услуги`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `услуги_заказа_ibfk_3` FOREIGN KEY (`id_сотрудника`) REFERENCES `сотрудники` (`id_сотрудника`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Выполненные услуги в заказе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `услуги_заказа`
--

LOCK TABLES `услуги_заказа` WRITE;
/*!40000 ALTER TABLE `услуги_заказа` DISABLE KEYS */;
INSERT INTO `услуги_заказа` VALUES (1,1,1,2,1,2000.00,NULL),(2,2,2,2,1,1500.00,NULL),(3,3,3,2,1,2500.00,NULL),(4,4,4,3,1,2000.00,NULL);
/*!40000 ALTER TABLE `услуги_заказа` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-17 14:16:20
