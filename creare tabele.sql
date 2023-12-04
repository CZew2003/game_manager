create database game_manager;

create table Champions (
	idChampion int primary key,
    name varchar(45),
    baseHealth int,
    baseMana int,
    manaType varchar(45),
    baseArmor int,
    baseMagicResist int,
    baseMovementSpeed int,
    baseHealthRegen int,
    baseAttackSpeed float,
    fullPrice int,
    shardPrice int,
    disenchantPrice int);
    
CREATE TABLE Skins (
    idSkin INT PRIMARY KEY,
    idChampion INT,
    name VARCHAR(45),
    priceRP INT,
    priceOrangeEssence INT,
    disenchantOrangeEssence INT,
    FOREIGN KEY (idChampion) REFERENCES Champions(idChampion)
);
    
CREATE TABLE Spells (
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
create table Items(
	idItem int primary key,
    name varchar(45),
    description varchar(90),
    attackDamage int,
    abilityPower int,
    abilityHaste int,
    armor int,
    magicResist int,
    lethality int);
    
create table Regions(
	idRegion int primary key,
    name varchar(45),
    serverBase varchar(45),
    players int);
    
create table Ranks(
    idRank int primary key,
    name varchar(45));
    
create table Clients(
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
    
create table Friends(
	idFriend int primary key,
    friend1 int,
    friend2 int,
    foreign key (friend1) references Client(idClient),
    foreign key (friend2) references Client(idClient));

create table Roles(
	idRole int primary key,
    name varchar(45));

create table Employees(
	idEmployee int primary key,
    name varchar(45),
    idClient int,
    salary int,
    hoursMonthly int,
    expirationContract date,
    role int,
    foreign key (idClient) references Client(idClient),
    foreign key (role) references Roles(idRole));
    
create table LootSkins(
	idLootSkin int primary key,
    idSkin int,
    idClient int,
    foreign key (idSkin) references Skins(idSkin),
    foreign key (idClient) references Client(idClient));
    
create table LootChampions(
	idLootSkin int primary key,
    idChampion int,
    idClient int,
    foreign key (idClient) references Client(idClient),
    foreign key (idChampion) references Champions(idChampion));
    
create table Teams(
	idTeam int primary key,
    name varchar(45));
    
create table Positions(
	idPosition int primary key,
    name varchar(45));
    
create table Matches(
	idMatch int primary key,
    winner int,
    duration int,
    foreign key (winner) references Teams(idTeam));
    
create table Runes(
	idRune int primary key,
    name varchar(45),
    description varchar(90));
    
CREATE TABLE PlayerMatch (
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
    FOREIGN KEY (idPlayer) REFERENCES Client(idClient),
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

    
    