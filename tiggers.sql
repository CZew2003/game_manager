DROP TRIGGER IF EXISTS champion_default_skin;

delimiter //

CREATE TRIGGER champion_default_skin AFTER INSERT ON champions
  FOR EACH ROW BEGIN
    INSERT INTO skins (idChampion, personalId, name, priceRP, priceOrangeEssence, disenchantOrangeEssence)
		VALUES(NEW.idChampion, 0, "default", 0, 0, 0);
  END; //
delimiter ;


DROP TRIGGER IF EXISTS update_region_count;
delimiter //

CREATE TRIGGER update_region_count AFTER INSERT ON clients
  FOR EACH ROW BEGIN
    UPDATE Regions SET players = players + 1 WHERE idRegion = NEW.region;
  END; //
delimiter ;

DROP TRIGGER IF EXISTS update_region_count_on_delete;
delimiter //

CREATE TRIGGER update_region_count_on_delete AFTER DELETE ON clients
  FOR EACH ROW BEGIN
    UPDATE Regions SET players = players - 1 WHERE idRegion = OLD.region;
  END; //
delimiter ;

DROP TRIGGER IF EXISTS create_event_insert_client;
delimiter //

CREATE TRIGGER create_event_insert_client AFTER INSERT ON clients
  FOR EACH ROW BEGIN
    INSERT INTO Events(description, eventTime)  values
		("S-a adaugat un client nou", curdate());
  END; //
delimiter ;

DROP TRIGGER IF EXISTS add_champions_to_new_client;
delimiter //

CREATE TRIGGER add_champions_to_new_client AFTER INSERT ON clients
  FOR EACH ROW BEGIN
		insert into clientchampions(idChampion, idClient) values
        ((select idChampion from champions where name="MonkeyKing"), NEW.idClient),
        ((select idChampion from champions where name="Ekko"), NEW.idClient),
        ((select idChampion from champions where name="Ksante"), NEW.idClient),
        ((select idChampion from champions where name="Lucian"), NEW.idClient),
        ((select idChampion from champions where name="Senna"), NEW.idClient);
  END; //
delimiter ;

DROP TRIGGER IF EXISTS add_default_skin;
delimiter //

CREATE TRIGGER add_default_skin AFTER INSERT ON clientchampions
  FOR EACH ROW BEGIN
		insert into clientskins(idSkin, idClient) values
			((select idSkin FROM skins where idChampion = NEW.idChampion and personalID = 0), NEW.idClient);
  END; //
delimiter ;

DROP TRIGGER IF EXISTS add_event_on_update;
delimiter //

CREATE TRIGGER add_event_on_update AFTER INSERT ON updates
  FOR EACH ROW BEGIN
		INSERT INTO Events(description, eventTime)  values
			("S-a adaugat un update nou", curdate());
  END; //
delimiter ;
