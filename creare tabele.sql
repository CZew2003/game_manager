create database if not exists game_manager;

use game_manager;

create table if not exists Champions (
	idChampion int primary key,
    name varchar(45),
    baseHealth int,
    baseMana int,
    manaType varchar(45),
    baseArmor int,
    baseMagicResist int,
    baseMovementSpeed int,
    baseHealthRegen int,
    baseDamage int,
    baseAttackSpeed float,
    fullPrice int,
    shardPrice int,
    disenchantPrice int);
    
CREATE TABLE if not exists Skins (
    idSkin INT PRIMARY KEY,
    idChampion INT,
	personalId INT,
    name VARCHAR(45),
    priceRP INT,
    priceOrangeEssence INT,
    disenchantOrangeEssence INT,
    FOREIGN KEY (idChampion) REFERENCES Champions(idChampion)
);
 
CREATE TABLE if not exists Spells (
    idSpell INT PRIMARY KEY,
    idChampion INT,
    name VARCHAR(45),
    description VARCHAR(90),
    position INT,
    baseAp INT,
    baseAd INT,
    cooldown INT,
    FOREIGN KEY (idChampion) REFERENCES Champions(idChampion)
);
create table if not exists Items(
	idItem int primary key,
    name varchar(45),
    description varchar(90),
    attackDamage int,
    abilityPower int,
    health int,
    armor int,
    magicResist int,
    criticalStrike int,
    health int,
    price int);

    
create table if not exists Regions(
	idRegion int primary key,
    name varchar(45),
    serverBase varchar(45),
    players int);
    
create table if not exists Ranks(
    idRank int primary key,
    name varchar(45));
    
create table if not exists Clients(
	idClient int primary key,
    region int,
    clientName varchar(45),
    password varchar(45),
    username varchar(45),
    blueEssence int,
    riotPoints int,
    orrangeEssence int,
    level int,
    ranking int,
    foreign key (region) references Regions(idRegion),
    foreign key (ranking) references Ranks(idRank));
    
create table if not exists Friends(
	idFriend int primary key,
    friend1 int,
    friend2 int,
    foreign key (friend1) references Clients(idClient),
    foreign key (friend2) references Clients(idClient));

create table if not exists Roles(
	idRole int primary key,
    name varchar(45));

create table if not exists Employees(
	idEmployee int primary key,
    name varchar(45),
    idClient int,
    salary int,
    hoursMonthly int,
    expirationContract date,
    role int,
    foreign key (idClient) references Clients(idClient),
    foreign key (role) references Roles(idRole));
    
create table if not exists LootSkins(
	idLootSkin int primary key,
    idSkin int,
    idClient int,
    foreign key (idSkin) references Skins(idSkin),
    foreign key (idClient) references Clients(idClient));
    
create table if not exists LootChampions(
	idLootSkin int primary key,
    idChampion int,
    idClient int,
    foreign key (idClient) references Clients(idClient),
    foreign key (idChampion) references Champions(idChampion));
    
create table if not exists Teams(
	idTeam int primary key,
    name varchar(45));
    
create table if not exists Positions(
	idPosition int primary key,
    name varchar(45));
    
create table if not exists Matches(
	idMatch int primary key,
    winner int,
    duration int,
    foreign key (winner) references Teams(idTeam));
    
create table if not exists Runes(
	idRune int primary key,
    name varchar(45),
    description varchar(90));
    
CREATE TABLE if not exists PlayerMatch (
    idPlayerMatch INT PRIMARY KEY,
    idPlayer INT,
    idMatch INT,
    primaryRunes INT,
    secondaryRunes INT,
    idChampion INT,
    idSkin INT,
    item1 INT,
    item2 INT,
    item3 INT,
    item4 INT,
    item5 INT,
    item6 INT,
    damageDealt INT,
    team INT,
    position INT,
    FOREIGN KEY (idPlayer) REFERENCES Clients(idClient),
    FOREIGN KEY (idMatch) REFERENCES Matches(idMatch),
    FOREIGN KEY (primaryRunes) REFERENCES Runes(idRune),
    FOREIGN KEY (secondaryRunes) REFERENCES Runes(idRune),
    FOREIGN KEY (idChampion) REFERENCES Champions(idChampion),
    FOREIGN KEY (idSkin) REFERENCES Skins(idSkin),
    FOREIGN KEY (item1) REFERENCES Items(idItem),
    FOREIGN KEY (item2) REFERENCES Items(idItem),
    FOREIGN KEY (item3) REFERENCES Items(idItem),
    FOREIGN KEY (item4) REFERENCES Items(idItem),
    FOREIGN KEY (item5) REFERENCES Items(idItem),
    FOREIGN KEY (item6) REFERENCES Items(idItem),
    FOREIGN KEY (team) REFERENCES Teams(idTeam),
    FOREIGN KEY (position) REFERENCES Positions(idPosition)
);

create table if not exists ClientSkins(
	idClientSkin int primary key,
    idClient int,
    idSkin int,
    foreign key (idClient) references Clients(idClient),
    foreign key (idSkin) references Skins(idSkin));
    
create table if not exists ClientChampions(
	idClientChampions int primary key,
    idClient int,
    idChampion int,
    foreign key (idClient) references Clients(idClient),
    foreign key (idChampion) references Champions(idChampion));
    
create table if not exists Events (
	idEvent int primary key auto_increment,
    description varchar(45),
    eventTime date);
    
create table if not exists Updates (
	idUpdate int primary key,
    updateNumber varchar(45));
    
create table if not exists UpdatesType (
	idUpdatesType int primary key,
    name varchar(45));
    
create table if not exists UpdateChampion (
	idUpdateChampion int primary key,
    idChampion int,
    idUpdate int,
    updateType int,
    foreign key (idChampion) references Champions(idChampion),
    foreign key (idUpdate) references Updates(idUpdate),
    foreign key (updateType) references UpdatesType(idUpdatesType));
    

create table if not exists UpdateSpell(
	idUpdateSpell int primary key,
    idSpell int,
    idUpdate int,
    updateType int,
    foreign key (idSpell) references Spells(idSpell),
    foreign key (idUpdate) references Updates(idUpdate),
    foreign key (updateType) references UpdatesType(idUpdatesType));
    

create table if not exists UpdateItem (
	idUpdateItem int primary key,
    idItem int,
    idUpdate int,
    updateType int,
    foreign key (idItem) references Items(idItem),
    foreign key (idUpdate) references Updates(idUpdate),
    foreign key (updateType) references UpdatesType(idUpdatesType));
    
    