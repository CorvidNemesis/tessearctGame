extends Node2D

var partaking_heroes = [];
var partaking_enemies = [];

var focused_hero: BattleHero = null;

signal assign_skill(skill:BattleSkill);
signal targeting(index:int)
signal next_turn();
signal package_skill();

var active_user: BattleEntity = null;
var active_skill: BattleSkill = null;
var active_target: BattleEntity = null;
