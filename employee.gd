extends Node2D

class_name employee

@export var display_name : String;
@export var display_hpBar: ProgressBar;
@export var display_mpBar: ProgressBar;
@export var display_spBar: ProgressBar;

@export var stat_maxHP = 100;
@export var stat_maxMP = 10;
@export var stat_str = 10;
@export var stat_cmp = 10;
@export var stat_def = 10;
@export var stat_agi = 10;
@export var stat_mpRecoverRate = 0.10;

# 0.0 - 2.0, 0 is the best 2 is the worst.

# Adenine is HP
@export var stat_rst_adenine = 1.0;
# Cytosine is MP %
@export var stat_rst_cytosine = 1.0;
# Guanine is HP %
@export var stat_rst_guanine = 1.0;
# Thymine is HP % and MP %
@export var stat_rst_thymine = 1.0;

var stat_currentHP = stat_maxHP;
var stat_currentMP = stat_maxMP;
