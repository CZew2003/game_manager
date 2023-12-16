DELIMITER //

CREATE PROCEDURE get_champions_for_player(IN p_ClientName varchar(100))
BEGIN
    SELECT ch.name
    FROM champions AS ch
    INNER JOIN lootchampions AS lc ON ch.idChampion = lc.idChampion
    INNER JOIN clients ON clients.idClient = lc.idClient
    WHERE clients.clientName = p_ClientName;
END //

DELIMITER ;
---------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE get_skins_for_player(IN p_ClientName varchar(100), p_campionAles VARCHAR(100))
BEGIN
    SELECT sk.name
    FROM skins AS sk
    INNER JOIN clientskins AS cs ON cs.idSkin = sk.idSkin
    INNER JOIN clients as cl ON cl.idClient = cs.idClient
    INNER JOIN champions as ch ON ch.idChampion = sk.idChampion
    WHERE cl.clientName = p_ClientName AND ch.name =  p_campionAles;
END //

DELIMITER ;

---------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE buy_rp(IN p_ClientName varchar(100), p_money INT)
BEGIN
	DECLARE v_price INT;
    DECLARE v_rpReceived INT;
    
    SELECT price, rpReceived
    INTO v_price, v_rpReceived
    FROM rpshop
    WHERE p_money = rpshop.price;
    
     IF v_price IS NOT NULL AND v_rpReceived IS NOT NULL THEN

        UPDATE clients
        SET riotPoints = riotPoints + v_rpReceived
        WHERE clients.clientName = p_ClientName;

        UPDATE riotBank
        SET balance = balance + v_price;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid price specified for purchase';
    END IF;
	
END //

DELIMITER ;


-------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE rp_to_OrrangeEssence(IN p_clientName VARCHAR(100), p_riotPoints INT)
BEGIN
    DECLARE v_orangeEssence INT;

    SET v_orangeEssence = p_riotPoints * 2;

    UPDATE clients
    SET orrangeEssence = orrangeEssence + v_orangeEssence,
        riotPoints = riotPoints - p_riotPoints
    WHERE clientName = p_clientName AND riotPoints >= p_riotPoints;

    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient riotPoints for conversion';
    END IF;
END //

DELIMITER ;

------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE rp_to_BlueEssence(IN p_clientName VARCHAR(100), p_riotPoints INT)
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

DELIMITER ;

--------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE BuySkinWithOrangeEssence(IN p_clientName VARCHAR(100), p_skinName VARCHAR(100))
BEGIN
	DECLARE v_OrangeEssenceBalance INT;
	DECLARE v_SkinPrice INT;
    DECLARE v_idSkin INT;
    DECLARE v_idSkinLoot INT;
    DECLARE v_idClient INT;
    
    SELECT idClient INTO v_idClient FROM clients WHERE clientName = p_clientName;
    SELECT orrangeEssence INTO v_OrangeEssenceBalance FROM clients WHERE clientName = p_clientName;
    
    SELECT idSkin, priceOrangeEssence
    INTO v_idSkin, v_SkinPrice
    FROM skins
    WHERE name = p_skinName;
    
    SELECT idLootSkin 
    INTO v_idSkinLoot 
    FROM lootskins
    WHERE idSkin = v_idSkin AND idClient = v_idClient;
    
   IF v_orangeEssenceBalance >= v_SkinPrice AND v_idSkinLoot IS NOT NULL THEN
   
		UPDATE clients
        SET orrangeEssence = orrangeEssence - v_SkinPrice
        WHERE clientName = p_clientName;
        
        INSERT INTO clientskins(idClient, idSkin) VALUES
        (v_idClient,v_idSkin);
        
        DELETE FROM lootskins
		WHERE idLootSkin = v_idSkinLoot;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient orangeEssence to buy the skin or no shard';
    END IF;
END //

DELIMITER ;

--------------------------------------------------------------------