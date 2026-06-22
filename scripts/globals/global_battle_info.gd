extends Node2D

var partaking_heroes = [];
var partaking_enemies = [];

var focused_hero: BattleHero = null;

signal assign_skill(skill:BattleSkill);
signal targeting(index:int)
signal next_turn();
