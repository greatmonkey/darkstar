---------------------------------------------
--  Dreadstorm
--
--  Description: Deals magical damage in an area of effect. Additional effect: Terror
--  Type: Magical
--  Wipes Shadows
--  Range: 13' radial
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
    return 1;
end;

function OnMobWeaponSkill(target, mob, skill)

-- TODO: Add EFFECT_TERROR once it actually does something.

	local dmgmod = 2.5;
	local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg() * 4,ELE_DARK,dmgmod,TP_MAB_BONUS,1);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_DARK,MOBPARAM_WIPE_SHADOWS);
	target:delHP(dmg);
	return dmg;
end;
