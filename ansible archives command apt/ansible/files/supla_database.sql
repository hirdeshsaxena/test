-- SQL Dump
--

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `supla`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `supla_on_channeladded`(IN `_device_id` INT, IN `_channel_id` INT)
    NO SQL
BEGIN

SET @type = NULL;

SELECT type INTO @type FROM supla_dev_channel WHERE `func` = 0 AND id = _channel_id;

IF @type = 3000 THEN

  UPDATE supla_dev_channel SET `func` = 40 WHERE id = _channel_id;

END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `supla_on_newdevice`(IN `_device_id` INT)
    MODIFIES SQL DATA
BEGIN

SET @name = NULL;

SET @c0 = NULL;
SET @c1 = NULL;
SET @c2 = NULL;

SET @c3 = NULL;
SET @c4 = NULL;
SET @c5 = NULL;


SELECT name INTO @name FROM supla_iodevice WHERE id = _device_id;

SELECT id INTO @c0 FROM supla_dev_channel WHERE iodevice_id = _device_id AND channel_number = 0 AND `func` = 0 AND type = 2000;

SELECT id INTO @c1 FROM supla_dev_channel WHERE iodevice_id = _device_id AND channel_number = 1 AND `func` = 0 AND type = 2000;

SELECT id INTO @c2 FROM supla_dev_channel WHERE iodevice_id = _device_id AND channel_number = 2 AND `func` = 0 AND type = 2000;

SELECT id INTO @c3 FROM supla_dev_channel WHERE iodevice_id = _device_id AND channel_number = 3 AND `func` = 0 AND type = 1000;

SELECT id INTO @c4 FROM supla_dev_channel WHERE iodevice_id = _device_id AND channel_number = 4 AND `func` = 0 AND type = 1000;

SELECT id INTO @c5 FROM supla_dev_channel WHERE iodevice_id = _device_id AND channel_number = 5 AND `func` = 0 AND type = 1000;


IF @c0 IS NOT NULL AND @c0 <> 0
   AND @c1 IS NOT NULL AND @c1 <> 0
   AND @c2 IS NOT NULL AND @c2 <> 0
   AND @c3 IS NOT NULL AND @c3 <> 0
   AND @c4 IS NOT NULL AND @c4 <> 0
   AND @c5 IS NOT NULL AND @c5 <> 0
   AND @name = 'RASBPBERRY PI B+ EXTENSION 01' THEN

  UPDATE supla_dev_channel SET `func` = 10, param1 = 6000, param2 = @c3 WHERE id = @c0;

  UPDATE supla_dev_channel SET `func` = 20, param1 = 500, param2 = @c4 WHERE id = @c1;
  
  UPDATE supla_dev_channel SET `func` = 30, param1 = 500, param2 = @c5 WHERE id = @c2;
  
  UPDATE supla_dev_channel SET `func` = 50, param1 = @c0 WHERE id = @c3;
  UPDATE supla_dev_channel SET `func` = 60, param1 = @c1 WHERE id = @c4;
  UPDATE supla_dev_channel SET `func` = 70, param1 = @c2 WHERE id = @c5;
  
END IF;


END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `supla_accessid`
--

CREATE TABLE IF NOT EXISTS `supla_accessid` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `password` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `caption` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `supla_client`
--

CREATE TABLE IF NOT EXISTS `supla_client` (
  `id` int(11) NOT NULL,
  `access_id` int(11) NOT NULL,
  `guid` binary(16) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reg_ipv4` int(10) unsigned NOT NULL,
  `reg_date` datetime NOT NULL,
  `last_access_ipv4` int(10) unsigned NOT NULL,
  `last_access_date` datetime NOT NULL,
  `software_version` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `protocol_version` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `supla_dev_channel`
--

CREATE TABLE IF NOT EXISTS `supla_dev_channel` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `func` int(11) NOT NULL,
  `param1` int(11) NOT NULL,
  `param2` int(11) NOT NULL,
  `caption` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `param3` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `channel_number` int(11) NOT NULL,
  `iodevice_id` int(11) NOT NULL,
  `flist` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `supla_iodevice`
--

CREATE TABLE IF NOT EXISTS `supla_iodevice` (
  `id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `comment` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reg_date` datetime NOT NULL,
  `last_connected` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `reg_ipv4` int(10) unsigned NOT NULL,
  `last_ipv4` int(11) DEFAULT NULL,
  `guid` binary(16) NOT NULL,
  `software_version` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `protocol_version` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `supla_location`
--

CREATE TABLE IF NOT EXISTS `supla_location` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `password` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `caption` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `supla_rel_aidloc`
--

CREATE TABLE IF NOT EXISTS `supla_rel_aidloc` (
  `access_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `supla_temperature_log`
--

CREATE TABLE IF NOT EXISTS `supla_temperature_log` (
  `id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `temperature` decimal(8,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `supla_temphumidity_log`
--

CREATE TABLE IF NOT EXISTS `supla_temphumidity_log` (
`id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `temperature` decimal(8,4) NOT NULL,
  `humidity` decimal(8,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `supla_user`
--

CREATE TABLE IF NOT EXISTS `supla_user` (
  `id` int(11) NOT NULL,
  `salt` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `reg_date` datetime NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `limit_aid` int(11) NOT NULL,
  `limit_loc` int(11) NOT NULL,
  `last_ipv4` int(11) DEFAULT NULL,
  `limit_iodev` int(11) NOT NULL,
  `limit_client` int(11) NOT NULL,
  `current_login` datetime DEFAULT NULL,
  `current_ipv4` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `supla_v_client`
--
CREATE TABLE IF NOT EXISTS `supla_v_client` (
`id` int(11)
,`access_id` int(11)
,`guid` binary(16)
,`name` varchar(100)
,`reg_ipv4` int(10) unsigned
,`reg_date` datetime
,`last_access_ipv4` int(10) unsigned
,`last_access_date` datetime
,`software_version` varchar(20)
,`protocol_version` int(11)
,`enabled` tinyint(1)
,`user_id` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `supla_v_client_channel`
--
CREATE TABLE IF NOT EXISTS `supla_v_client_channel` (
`id` int(11)
,`type` int(11)
,`func` int(11)
,`param1` int(11)
,`param2` int(11)
,`caption` varchar(100)
,`param3` int(11)
,`user_id` int(11)
,`channel_number` int(11)
,`iodevice_id` int(11)
,`client_id` int(11)
,`location_id` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `supla_v_client_location`
--
CREATE TABLE IF NOT EXISTS `supla_v_client_location` (
`id` int(11)
,`caption` varchar(100)
,`client_id` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `supla_v_device_accessid`
--
CREATE TABLE IF NOT EXISTS `supla_v_device_accessid` (
`id` int(11)
,`user_id` int(11)
,`enabled` int(4) unsigned
,`password` varchar(32)
,`limit_client` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `supla_v_device_location`
--
CREATE TABLE IF NOT EXISTS `supla_v_device_location` (
`id` int(11)
,`user_id` int(11)
,`enabled` int(4) unsigned
,`limit_iodev` int(11)
,`password` varchar(32)
);

-- --------------------------------------------------------

--
-- Struktura widoku `supla_v_client`
--
DROP TABLE IF EXISTS `supla_v_client`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `supla_v_client` AS select `c`.`id` AS `id`,`c`.`access_id` AS `access_id`,`c`.`guid` AS `guid`,`c`.`name` AS `name`,`c`.`reg_ipv4` AS `reg_ipv4`,`c`.`reg_date` AS `reg_date`,`c`.`last_access_ipv4` AS `last_access_ipv4`,`c`.`last_access_date` AS `last_access_date`,`c`.`software_version` AS `software_version`,`c`.`protocol_version` AS `protocol_version`,`c`.`enabled` AS `enabled`,`a`.`user_id` AS `user_id` from (`supla_client` `c` join `supla_accessid` `a` on((`a`.`id` = `c`.`access_id`)));

-- --------------------------------------------------------

--
-- Struktura widoku `supla_v_client_channel`
--
DROP TABLE IF EXISTS `supla_v_client_channel`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `supla_v_client_channel` AS select `c`.`id` AS `id`,`c`.`type` AS `type`,`c`.`func` AS `func`,`c`.`param1` AS `param1`,`c`.`param2` AS `param2`,`c`.`caption` AS `caption`,`c`.`param3` AS `param3`,`c`.`user_id` AS `user_id`,`c`.`channel_number` AS `channel_number`,`c`.`iodevice_id` AS `iodevice_id`,`cl`.`id` AS `client_id`,`r`.`location_id` AS `location_id` from (((((`supla_dev_channel` `c` join `supla_iodevice` `d` on((`d`.`id` = `c`.`iodevice_id`))) join `supla_location` `l` on((`l`.`id` = `d`.`location_id`))) join `supla_rel_aidloc` `r` on((`r`.`location_id` = `l`.`id`))) join `supla_accessid` `a` on((`a`.`id` = `r`.`access_id`))) join `supla_client` `cl` on((`cl`.`access_id` = `r`.`access_id`))) where ((`c`.`func` is not null) and (`c`.`func` <> 0) and (`d`.`enabled` = 1) and (`l`.`enabled` = 1) and (`a`.`enabled` = 1));

-- --------------------------------------------------------

--
-- Struktura widoku `supla_v_client_location`
--
DROP TABLE IF EXISTS `supla_v_client_location`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `supla_v_client_location` AS select `l`.`id` AS `id`,`l`.`caption` AS `caption`,`c`.`id` AS `client_id` from ((`supla_rel_aidloc` `al` join `supla_location` `l` on((`l`.`id` = `al`.`location_id`))) join `supla_client` `c` on((`c`.`access_id` = `al`.`access_id`))) where (`l`.`enabled` = 1);

-- --------------------------------------------------------

--
-- Struktura widoku `supla_v_device_accessid`
--
DROP TABLE IF EXISTS `supla_v_device_accessid`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `supla_v_device_accessid` AS select `a`.`id` AS `id`,`a`.`user_id` AS `user_id`,cast(`a`.`enabled` as unsigned) AS `enabled`,`a`.`password` AS `password`,`u`.`limit_client` AS `limit_client` from (`supla_accessid` `a` join `supla_user` `u` on((`u`.`id` = `a`.`user_id`)));

-- --------------------------------------------------------

--
-- Struktura widoku `supla_v_device_location`
--
DROP TABLE IF EXISTS `supla_v_device_location`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `supla_v_device_location` AS select `l`.`id` AS `id`,`l`.`user_id` AS `user_id`,cast(`l`.`enabled` as unsigned) AS `enabled`,`u`.`limit_iodev` AS `limit_iodev`,`l`.`password` AS `password` from (`supla_location` `l` join `supla_user` `u` on((`u`.`id` = `l`.`user_id`)));

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `supla_accessid`
--
ALTER TABLE `supla_accessid`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_A5549B6CA76ED395` (`user_id`);

--
-- Indexes for table `supla_client`
--
ALTER TABLE `supla_client`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_CLIENTAPP` (`id`,`guid`),
  ADD KEY `IDX_5430007F4FEA67CF` (`access_id`);

--
-- Indexes for table `supla_dev_channel`
--
ALTER TABLE `supla_dev_channel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_CHANNEL` (`iodevice_id`,`channel_number`),
  ADD KEY `IDX_81E928C9A76ED395` (`user_id`),
  ADD KEY `IDX_81E928C9125F95D6` (`iodevice_id`);

--
-- Indexes for table `supla_iodevice`
--
ALTER TABLE `supla_iodevice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_793D49D2B6FCFB2` (`guid`),
  ADD KEY `IDX_793D49D64D218E` (`location_id`),
  ADD KEY `IDX_793D49DA76ED395` (`user_id`);

--
-- Indexes for table `supla_location`
--
ALTER TABLE `supla_location`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_3698128EA76ED395` (`user_id`);

--
-- Indexes for table `supla_rel_aidloc`
--
ALTER TABLE `supla_rel_aidloc`
  ADD PRIMARY KEY (`location_id`,`access_id`),
  ADD KEY `IDX_2B1590414FEA67CF` (`access_id`),
  ADD KEY `IDX_2B15904164D218E` (`location_id`);

--
-- Indexes for table `supla_temperature_log`
--
ALTER TABLE `supla_temperature_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `channel_id_idx` (`channel_id`),
  ADD KEY `date_idx` (`date`);

--
-- Indexes for table `supla_user`
--
ALTER TABLE `supla_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_71BAEAC6E7927C74` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `supla_accessid`
--
ALTER TABLE `supla_accessid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `supla_client`
--
ALTER TABLE `supla_client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `supla_dev_channel`
--
ALTER TABLE `supla_dev_channel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `supla_iodevice`
--
ALTER TABLE `supla_iodevice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `supla_location`
--
ALTER TABLE `supla_location`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `supla_temperature_log`
--
ALTER TABLE `supla_temperature_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `supla_user`
--
ALTER TABLE `supla_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `supla_accessid`
--
ALTER TABLE `supla_accessid`
  ADD CONSTRAINT `FK_A5549B6CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `supla_user` (`id`);

--
-- Ograniczenia dla tabeli `supla_client`
--
ALTER TABLE `supla_client`
  ADD CONSTRAINT `FK_5430007F4FEA67CF` FOREIGN KEY (`access_id`) REFERENCES `supla_accessid` (`id`);

--
-- Ograniczenia dla tabeli `supla_dev_channel`
--
ALTER TABLE `supla_dev_channel`
  ADD CONSTRAINT `FK_81E928C9125F95D6` FOREIGN KEY (`iodevice_id`) REFERENCES `supla_iodevice` (`id`),
  ADD CONSTRAINT `FK_81E928C9A76ED395` FOREIGN KEY (`user_id`) REFERENCES `supla_user` (`id`);

--
-- Ograniczenia dla tabeli `supla_iodevice`
--
ALTER TABLE `supla_iodevice`
  ADD CONSTRAINT `FK_793D49D64D218E` FOREIGN KEY (`location_id`) REFERENCES `supla_location` (`id`),
  ADD CONSTRAINT `FK_793D49DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `supla_user` (`id`);

--
-- Ograniczenia dla tabeli `supla_location`
--
ALTER TABLE `supla_location`
  ADD CONSTRAINT `FK_3698128EA76ED395` FOREIGN KEY (`user_id`) REFERENCES `supla_user` (`id`);

--
-- Ograniczenia dla tabeli `supla_rel_aidloc`
--
ALTER TABLE `supla_rel_aidloc`
  ADD CONSTRAINT `FK_2B1590414FEA67CF` FOREIGN KEY (`access_id`) REFERENCES `supla_accessid` (`id`),
  ADD CONSTRAINT `FK_2B15904164D218E` FOREIGN KEY (`location_id`) REFERENCES `supla_location` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
