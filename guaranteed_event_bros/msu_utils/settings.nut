local generalPage = ::GuaranteedEventBros.Mod.ModSettings.addPage("Page", "General");

generalPage.addTitle("allOriginsTitle", "All Origins");
generalPage.addDivider("allOriginsDivider");

local guaranteeRunawayLaborers = generalPage.addBooleanSetting("GuaranteeRunawayLaborers", true, "100% Chance for Runaway Laborers");
local guaranteeThiefCaught = generalPage.addBooleanSetting("GuaranteeThiefCaught", true, "100% Chance for Thief Caught");
local guaranteeTheHorseman = generalPage.addBooleanSetting("GuaranteeTheHorseman", true, "100% Chance for The Horseman");

generalPage.addTitle("anatomistOriginTitle", "Anatomist Origin Only");
generalPage.addDivider("anatomistOriginDivider");
local guaranteeBlightedGuySetting = generalPage.addBooleanSetting("GuaranteeBlightedGuy", true, "100% Chance for Blighted Guy");

guaranteeRunawayLaborers.addAfterChangeCallback(function ( _oldValue )
{
	if (::GuaranteedEventBros.GameLoading || ::World == null || ::World.Events == null) {
		return;
	}

    ::GuaranteedEventBros.toggleEventSetting("event.runaway_laborers", this.getValue());
});

guaranteeThiefCaught.addAfterChangeCallback(function ( _oldValue )
{
	if (::GuaranteedEventBros.GameLoading || ::World == null || ::World.Events == null) {
		return;
	}

    ::GuaranteedEventBros.toggleEventSetting("event.thief_caught", this.getValue());
});

guaranteeTheHorseman.addAfterChangeCallback(function ( _oldValue )
{
	if (::GuaranteedEventBros.GameLoading || ::World == null || ::World.Events == null) {
		return;
	}

    ::GuaranteedEventBros.toggleEventSetting("event.the_horseman", this.getValue());
});

guaranteeBlightedGuySetting.addAfterChangeCallback(function ( _oldValue )
{
	if (::GuaranteedEventBros.GameLoading || ::World == null || ::World.Events == null) {
		return;
	}

    ::GuaranteedEventBros.toggleEventSetting("event.anatomist_helps_blighted_guy_1", this.getValue());
});