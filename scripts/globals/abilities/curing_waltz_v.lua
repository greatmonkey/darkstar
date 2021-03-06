-----------------------------------
-- Ability: Curing Waltz V
-----------------------------------
 
require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
    if (target:getHP() == 0) then
		return MSGBASIC_CANNOT_ON_THAT_TARG,0;
    elseif (player:hasStatusEffect(EFFECT_TRANCE)) then
		return 0,0;
	elseif (player:getTP() < 80) then
		return MSGBASIC_NOT_ENOUGH_TP,0;
	else
		player:delTP(80);
		return 0,0;
	end
end;

function OnUseAbility(player, target, ability)

	--Grabbing variables.
	local vit = target:getStat(MOD_VIT);
	local chr = player:getStat(MOD_CHR);
	local mjob = player:getMainJob(); --19 for DNC main.
	local cure = 0;

	--Performing mj check.
	if(mjob == 19) then
		cure = (vit+chr)*1.25+600;
	end

    -- apply waltz modifiers
    cure = math.floor(cure * (1.0 + (player:getMod(MOD_WALTZ_POTENTCY)/100)));

	--Reducing TP.

	--Applying server mods....
	cure = cure * CURE_POWER;

	--Cap the final amount to max HP.
	if((target:getMaxHP() - target:getHP()) < cure) then
		cure = (target:getMaxHP() - target:getHP());
	end

	--Do it
	target:restoreHP(cure);
	player:updateEnmityFromCure(target,cure);

	return cure;

end;