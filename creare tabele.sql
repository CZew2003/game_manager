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
    
create table Skins(
	idSkin int primary key,
    idChampion int,
    name varchar(45),
    priceRP int,
    priceOrangeEssence int,
    disenchantOrangeEssance int,
    foreign key (idChampion) references Champions.idChampion);
    
create table Spells(
	idSpell int primary key,
    idChampion int,
    name varchar(45),
    description varchar(90),
    position int,
    baseAp int,
    baseAd int,
    cooldown int,
    foreign key (idChampion) references Champions.idChampion);
    
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
    foreign key (region) references Regions.idRegion,
    foreign key (ranking) references Ranks.idRank);
    
create table Friends(
	idFriend int primary key,
    friend1 int,
    friend2 int,
    foreign key (friend1) references Client.idClient,
    foreign key (friend2) references Client.idClient);

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
    foreign key (idClient) references Client.idClient,
    foreign key (role) references Roles.idRole);
    
create table LootSkins(
	idLootSkin int primary key,
    idSkin int,
    idClient int,
    foreign key (idSkin) references Skins.idSkin,
    foreign key (idClient) references Client.idClient);
    
create table LootChampions(
	idLootSkin int primary key,
    idChampion int,
    idClient int,
    foreign key (idSkin) references Skins.idSkin,
    foreign key (idChampion) references Champions.idChampion);
    
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
    foreign key (winner) references Teams.idTeam);
    
create table Runes(
	idRune int primary key,
    name varchar(45),
    description varchar(90));
    
create table PlayerMatch(
	idPlayerMatch int primary key,
    idPlayer int,
    idMatch int,
    primaryRunes int,
    secondaryRunes int,
    idChampion int,
    idSkin int,
    item1 int,
    item2 int,
    item3 int,
    item4 int,
    item5 int,
    item6 int,
    damageDealt int,
    teaam int,
    position int,
    foreign key (idPlayer) references Client.idClient,
    foreign key (idMatch) references Matches.idMatch,
    foreign key (primaryRunes) references Runes.idRune,
    foreign key (secondaryRunes) references Runes.idRune,
    foreign key (idChampion) references Champions.idChampion,
    foreign key (idSkin) references Skins.idSkin,
    foreign key (item1) references Items.idItem,
    foreign key (item2) references Items.idItem,
    foreign key (item3) references Items.idItem,
    foreign key (item4) references Items.idItem,
    foreign key (item5) references Items.idItem,
    foreign key (item6) references Items.idItem,
    foreign key (team) references Teams.idTeam,
    foreign key (position) references Positions.idPosition);
    
    