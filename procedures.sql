DELIMITER //

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddEmployee`(IN p_nume VARCHAR(100), p_clientName VARCHAR(100), p_salary INT, p_hoursMonthly INT, p_expirationContract DATE)
BEGIN
    DECLARE v_idClient INT;
    
    SELECT idClient INTO v_idClient FROM clients WHERE username = p_clientName;
    
    INSERT INTO employees(name, idClient, salary, hoursMonthly, expirationContract, role) VALUES
    (p_nume, v_idClient, p_salary, p_hoursMonthly, p_expirationContract, 1);

END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddFriend`(IN p_clientName1 VARCHAR(100), p_clientName2 VARCHAR(100))
BEGIN
    DECLARE v_clientid1 INT;
    DECLARE v_clientid2 INT;
    DECLARE v_friendsid INT;

    IF p_clientName1 = p_clientName2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Friends already or one or both do not exist';
    END IF;

    SELECT idClient INTO v_clientid1 FROM clients WHERE username = p_clientName1;
    SELECT idClient INTO v_clientid2 FROM clients WHERE username = p_clientName2;

    SELECT idFriend INTO v_friendsid
    FROM friends
    WHERE (friend1 = v_clientid1 AND friend2 = v_clientid2)
       OR (friend1 = v_clientid2 AND friend2 = v_clientid1);

    IF v_friendsid IS NULL AND v_clientid1 IS NOT NULL AND v_clientid2 IS NOT NULL THEN
        INSERT INTO friends (friend1, friend2) VALUES 
        (v_clientid1, v_clientid2);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Friends already or one or both do not exist';
    END IF;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `buy_rp`(IN p_ClientName varchar(100), p_money INT)
BEGIN
    DECLARE v_price INT;
    DECLARE v_rpReceived INT;
    
    SELECT price, rpReceived INTO v_price, v_rpReceived FROM rpshop WHERE p_money = rpshop.price;
    
    IF v_price IS NOT NULL AND v_rpReceived IS NOT NULL THEN
        UPDATE clients
        SET riotPoints = riotPoints + v_rpReceived
        WHERE clients.username = p_ClientName;

        UPDATE riotBank
        SET balance = balance + v_price;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid price specified for purchase';
    END IF;
    
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuyChampShardWithRP`(IN p_numeClient VARCHAR(100))
BEGIN
    DECLARE v_idClient INT;
    DECLARE v_idChampion INT;
    DECLARE rp_client INT;

    SELECT idClient
    INTO v_idClient
    FROM clients
    WHERE p_numeClient = username;

	SELECT clients.riotPoints
    INTO rp_client
    FROM clients
    WHERE p_numeClient = username;

    SELECT idChampion
    INTO v_idChampion
    FROM champions
    ORDER BY RAND()
    LIMIT 1;
	IF rp_client > 9 THEN
		insert into lootchampions(idChampion, idClient) values
		(v_idChampion, v_idClient);

		UPDATE clients
		SET riotPoints = riotPoints - 10
		WHERE idClient = v_idClient;
	ELSE 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient riotPoints';
    END IF;

END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuyChampWithShard`(IN p_idLootChampion INT)
BEGIN
    DECLARE v_shardPrice INT;
    DECLARE v_idChampion INT;
    DECLARE v_ChampionOwned INT;
    DECLARE v_idClient INT;

    SELECT idChampion 
    INTO v_idChampion 
    FROM lootchampions 
    WHERE idLootChampion = p_idLootChampion;
    
    SELECT idClient 
    INTO v_idClient 
    FROM lootchampions 
    WHERE idLootChampion = p_idLootChampion;

    SELECT shardPrice
    INTO v_shardPrice
    FROM champions
    WHERE idChampion = v_idChampion;

    SELECT idClientChampions 
    INTO v_ChampionOwned 
    FROM clientchampions 
    WHERE idClient = v_idClient AND idChampion = v_idChampion;

    IF v_idChampion IS NOT NULL AND v_ChampionOwned IS NULL THEN

        INSERT INTO clientchampions (idChampion, idClient) VALUES
        (v_idChampion, v_idClient);

        UPDATE clients
        SET blueEssence = blueEssence - v_shardPrice
        WHERE idClient = v_idClient;

        DELETE FROM lootchampions
        where idChampion = v_idChampion AND idLootChampion = p_idLootChampion;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shard does not exits or champion not owned';
    END IF;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuySkinShardWithRP`(IN p_numeClient VARCHAR(100))
BEGIN
    DECLARE v_idClient INT;
    DECLARE v_idSkin INT;
    DECLARE rp_client INT;

    SELECT idClient
    INTO v_idClient
    FROM clients
    WHERE p_numeClient = username;

	SELECT clients.riotPoints
    INTO rp_client
    FROM clients
    WHERE p_numeClient = username;

    SELECT idSkin
    INTO v_idSkin
    FROM skins
    ORDER BY RAND()
    LIMIT 1;

	IF rp_client > 99 THEN
		insert into lootskins(idSkin, idClient) values
		(v_idSkin, v_idClient);
        
		UPDATE clients
		SET riotPoints = riotPoints - 100
		WHERE idClient = v_idClient;
	ELSE 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient riotPoints';
    END IF;
	
END //


CREATE DEFINER=`root`@`localhost` PROCEDURE `BuySkinWithOrangeEssence`(IN p_clientName VARCHAR(100), p_championName VARCHAR(100))
BEGIN
	DECLARE v_blueEssence INT;
	DECLARE v_ChampionPrice INT;
    DECLARE v_idChampion INT;
    DECLARE v_idChampionLoot INT;
    DECLARE v_idClient INT;
    
    SELECT idClient INTO v_idClient FROM clients WHERE username = p_clientName;
    SELECT blueEssence INTO v_blueEssence FROM clients WHERE username = p_clientName;
    
    SELECT idChampion, fullPrice
    INTO v_idChampion, v_ChampionPrice
    FROM champions
    WHERE name = p_championName;
    
   IF v_blueEssence >= v_ChampionPrice THEN
   
		UPDATE clients
        SET blueEssence = blueEssence - v_ChampionPrice
        WHERE username = p_clientName;
        
        INSERT INTO clientchampions(idClient, idChampion) VALUES
        (v_idClient, v_idChampion);

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient orangeEssence to buy the skin or no shard';
    END IF;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuySkinWithRP`(IN p_clientName VARCHAR(100), p_skinName VARCHAR(100))
BEGIN
    DECLARE v_riotPoints INT;
    DECLARE v_priceRP INT;
    DECLARE v_idSkin INT;
    DECLARE v_idClient INT;
    DECLARE v_idChampion INT;
    DECLARE v_idClientChampions INT;

    SELECT idClient INTO v_idClient FROM clients WHERE clientName = p_clientName;
    SELECT riotPoints INTO v_riotPoints FROM clients WHERE clientName = p_clientName;

    SELECT idSkin, priceRP
    INTO v_idSkin, v_priceRP
    FROM skins
    WHERE name = p_skinName;

    SELECT idChampion
    INTO v_idChampion
    FROM skins
    WHERE v_idSkin = idSkin;

    SELECT idClientChampions
    INTO v_idClientChampions
    FROM clientchampions
    WHERE idChampion = v_idChampion and idClient = v_idClient;

   IF v_riotPoints >= v_priceRP AND v_idClientChampions IS NOT NULL THEN

        UPDATE clients
        SET riotPoints = riotPoints - v_riotPoints
        WHERE clientName = p_clientName;

        INSERT INTO clientskins(idClient, idSkin) VALUES
        (v_idClient,v_idSkin);

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient riotPoints to buy the skin or champion not owned';
    END IF;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuySkinWithShard`(IN p_numeClient VARCHAR(100), p_idLootSkin INT)
BEGIN
    DECLARE v_shardPrice INT;
    DECLARE v_idSkin INT;
    DECLARE v_idChampion INT;
    DECLARE v_idClient INT;
    DECLARE v_ChampionOwned INT;

    SELECT idClient
    INTO v_idClient
    FROM clients
    WHERE username = p_numeClient;

    SELECT idSkin
    INTO v_idSkin 
    FROM lootskins 
    WHERE p_idLootSkin = idLootSkin AND idClient = v_idClient;

    SELECT priceOrangeEssence
    INTO v_shardPrice
    FROM skins
    WHERE v_idSkin = idSkin;

    SELECT idChampion
    INTO v_idChampion
    FROM skins
    WHERE idSkin = v_idSkin;

    SELECT idChampion 
    INTO v_ChampionOwned 
    FROM clientchampions 
    WHERE idClient = v_idClient AND idChampion = v_idChampion;

    IF v_idSkin IS NOT NULL AND v_ChampionOwned IS NOT NULL AND v_ChampionOwned = v_idChampion THEN

        INSERT INTO clientskins (idSkin, idClient) VALUES
        (v_idSkin, v_idClient);

        UPDATE clients
        SET orrangeEssence = orrangeEssence - v_shardPrice
        WHERE idClient = v_idClient;

        DELETE FROM lootskins
        where idSkin = v_idSkin AND idLootSkin = p_idLootSkin;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shard does not exits or skin owned';
    END IF;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `creare_client`(
    IN region VARCHAR(45),
    IN clientName VARCHAR(45),
    IN password VARCHAR(45),
    OUT verify BOOL
)
BEGIN
    DECLARE regionId INT;
    DECLARE existsAccount INT;

    -- Get the region ID based on the provided region name
    SELECT idRegion INTO regionId FROM regions WHERE name = region;

    -- Check if the client account already exists
    SELECT COUNT(*) INTO existsAccount FROM Clients WHERE username = clientName;

    -- If account already exists, set verify to false
    IF existsAccount > 0 THEN
        SET verify = FALSE;
    ELSE
        -- Insert a new client if the account doesn't exist
        INSERT INTO clients (
            region,
            username,
            password,
            blueEssence,
            riotPoints,
            orrangeEssence,
            ranking,
            statusMatches
        ) VALUES (
            regionId,clientName, password,10000, 1000, 0, 1, 0);
        -- Set verify to true as the new client has been successfully created
        SET verify = TRUE;
    END IF;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `DisenchantChampShard`(IN p_numeClient VARCHAR(100), p_idLootChamp int)
BEGIN
    DECLARE v_disenchantPrice INT;
    DECLARE v_idChampion INT;
    DECLARE v_idClient INT;

    SELECT idClient
    INTO v_idClient
    FROM clients
    WHERE username = p_numeClient;

    SELECT idChampion
    INTO v_idChampion
    FROM lootchampions 
    WHERE idLootChampion = p_idLootChamp AND idClient = v_idClient;

    SELECT disenchantPrice
    INTO v_disenchantPrice
    FROM champions
    WHERE idChampion = v_idChampion;

    IF v_idChampion IS NOT NULL THEN
        UPDATE clients
        SET blueEssence = blueEssence + v_disenchantPrice
        WHERE idClient = v_idClient;

        DELETE FROM lootchampions
        WHERE idLootChampion = p_idLootChamp;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shard does not exits';
    END IF;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `DisenchantSkin`(IN p_numeClient VARCHAR(100), p_idLootSkin int)
BEGIN
    DECLARE v_disenchantOrangeEssence INT;
    DECLARE v_idSkin INT;
    DECLARE v_idClient INT;

    SELECT idClient
    INTO v_idClient
    FROM clients
    WHERE username = p_numeClient;

    SELECT idSkin
    INTO v_idSkin 
    FROM lootskins 
    WHERE p_idLootSkin = idLootSkin AND idClient = v_idClient;

    SELECT disenchantOrangeEssence
    INTO v_disenchantOrangeEssence
    FROM skins
    WHERE idSkin = v_idSkin;

    IF v_idSkin IS NOT NULL THEN
        UPDATE clients
        SET orrangeEssence = orrangeEssence + v_disenchantOrangeEssence
        WHERE idClient = v_idClient;

        DELETE FROM lootskins
        WHERE idLootSkin = p_idLootSkin;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shard does not exits';
    END IF;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `rp_to_BlueEssence`(IN p_clientName VARCHAR(100), p_riotPoints INT)
BEGIN
    DECLARE v_blueEssence INT;

    SET v_blueEssence = p_riotPoints * 10;

    UPDATE clients
    SET blueEssence = blueEssence + v_blueEssence,
        riotPoints = riotPoints - p_riotPoints
    WHERE clientName = p_clientName AND riotPoints >= p_riotPoints;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient riotPoints for conversion';
    END IF;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `rp_to_OrrangeEssence`(IN p_clientName VARCHAR(100), p_riotPoints INT)
BEGIN
    DECLARE v_orangeEssence INT;

    SET v_orangeEssence = p_riotPoints * 2;

    UPDATE clients
    SET orrangeEssence = orrangeEssence + v_orangeEssence,
        riotPoints = riotPoints - p_riotPoints
    WHERE username = p_clientName AND riotPoints >= p_riotPoints;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient riotPoints for conversion';
    END IF;
END //


CREATE DEFINER=`root`@`localhost` PROCEDURE `StartMatch`()
BEGIN
    DECLARE TeamNumber INT;
    DECLARE maxMatchID INT;
    DECLARE randomChampion INT;
    DECLARE randomSkin INT;
    DECLARE item1 INT;
    DECLARE item2 INT;
    DECLARE item3 INT;
    DECLARE item4 INT;
    DECLARE item5 INT;
    DECLARE item6 INT;
    DECLARE client_id INT;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE championShard INT;
    DECLARE random_clients_cursor CURSOR FOR
        SELECT clients.idClient
        FROM clients
        LEFT JOIN employees
        on employees.idClient = clients.idClient
        where idEmployee is null
        ORDER BY RAND()
        LIMIT 10;
	
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET TeamNumber = 0;

    INSERT INTO matches(winner, duration)
    SELECT FLOOR(1 + RAND() * 2) AS winner, FLOOR(RAND() * (50 - 15 + 1) + 15) AS duration;

    SELECT MAX(idMatch)
    INTO maxMatchID
    FROM matches;

    OPEN random_clients_cursor;

    -- START OF LOOP
    read_loop: LOOP
        FETCH random_clients_cursor INTO client_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT idItem INTO item1 FROM items ORDER BY RAND() LIMIT 1;
        SELECT idItem INTO item2 FROM items ORDER BY RAND() LIMIT 1;
        SELECT idItem INTO item3 FROM items ORDER BY RAND() LIMIT 1;
        SELECT idItem INTO item4 FROM items ORDER BY RAND() LIMIT 1;
        SELECT idItem INTO item5 FROM items ORDER BY RAND() LIMIT 1;
        SELECT idItem INTO item6 FROM items ORDER BY RAND() LIMIT 1;

        SELECT idChampion
        INTO randomChampion
        FROM clientchampions
        WHERE idClient = client_id
        ORDER BY RAND()
        LIMIT 1;

        SELECT cs.idSkin
        INTO randomSkin
        FROM clientskins as cs
        INNER JOIN skins ON skins.idSkin = cs.idSkin
        WHERE skins.idChampion = randomChampion
        ORDER BY RAND()
        LIMIT 1;

		IF TeamNumber DIV 5  + 1 = 1 THEN
			update clients set clients.statusMatches = clients.statusMatches + 1 where clients.idClient = client_id;
            select idChampion into championShard from champions order by rand() limit 1;
            insert into lootchampions (idClient, idChampion) values (client_id, championShard);
		ELSE
			update clients set clients.statusMatches = clients.statusMatches - 1 where clients.idClient = client_id;
		END IF;

        INSERT INTO playermatch(idPlayer, idMatch, primaryRunes, secondaryRunes, idChampion, idSkin, item1, item2, item3, item4, item5, item6, damageDealt, team, position)
        VALUES (client_id, maxMatchID, FLOOR(1 + RAND() * 5), FLOOR(1 + RAND() * 5), randomChampion, randomSkin,
                item1, item2, item3, item4, item5, item6, FLOOR(2000 + RAND() * (30000 - 2000 + 1)), TeamNumber DIV 5 + 1, TeamNumber MOD 5 + 1);

        SET TeamNumber = TeamNumber + 1;

        -- Process each randomly selected client as needed
        -- You can add your logic here
        SELECT client_id; -- Adjust this based on your needs
    END LOOP;
    -- END OF LOOP

    CLOSE random_clients_cursor;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateChampion`(
    IN p_numeChampion VARCHAR(100),
    IN p_fullPrice INT,
    IN p_shardPrice INT,
    IN p_disenchantPrice INT,
    IN p_baseHealth INT,
    IN p_baseMana INT,
    IN p_baseArmor INT,
    IN p_baseMagicResist INT,
    IN p_baseMovement INT,
    IN p_baseHealthRegen INT,
    IN p_Damage INT,
    IN p_baseAttackSpeed INT
)
BEGIN
    UPDATE champions
    SET fullPrice = p_fullPrice,
        shardPrice = p_shardPrice,
        disenchantPrice = p_disenchantPrice,
        baseHealth = p_baseHealth,
        baseMana = p_baseMana,
        baseArmor = p_baseArmor,
        baseMagicResist = p_baseMagicResist,
        baseMovementSpeed = p_baseMovement,
        baseHealthRegen = p_baseHealthRegen,
        baseDamage = p_Damage,
        baseAttackSpeed = p_baseAttackSpeed
    WHERE name = p_numeChampion;
END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateClient`(IN p_numeClient VARCHAR(100), rp INT, blue INT, orange INT)
BEGIN

    UPDATE clients
    SET riotPoints = rp, blueEssence = blue, orrangeEssence = orange
    WHERE username = p_numeClient;

END //

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSkin`(IN p_numeSkin VARCHAR(100), p_priceRP INT, p_priceOrangeEssence INT, p_disenchantOrrangeEssence INT)
BEGIN

    UPDATE skins
    SET priceRP = p_priceRP, priceOrangeEssence = p_priceOrangeEssence, disenchantOrangeEssence = p_disenchantOrrangeEssence
    WHERE name = p_numeSkin;

END //

DELIMITER ;
