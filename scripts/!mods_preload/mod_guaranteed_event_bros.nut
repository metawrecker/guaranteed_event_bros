::GuaranteedEventBros <- {
	ID = "mod_guaranteed_event_bros",
	Name = "Guaranteed Event Bros",
	Version = "1.0.0",
	GitHubUrl = "https://github.com/metawrecker/guaranteed_event_bros",
	NexusUrl = "",
	GameLoading = true
}

local requiredMods = [
	"vanilla >= 1.5.1-6",
	"mod_msu >= 1.3.0",
	"mod_modern_hooks >= 0.4.10"
];

local modLoadOrder = [];
foreach (mod in requiredMods) {
	local idx = mod.find(" ");
	modLoadOrder.push(">" + (idx == null ? mod : mod.slice(0, idx)));
}

::GuaranteedEventBros.HooksMod <- ::Hooks.register(::GuaranteedEventBros.ID, ::GuaranteedEventBros.Version, ::GuaranteedEventBros.Name);
::GuaranteedEventBros.HooksMod.require(requiredMods);

::GuaranteedEventBros.userGivesPermission <- function (settingName)
{
	return ::GuaranteedEventBros.Mod.ModSettings.getSetting(settingName).getValue();
}

::GuaranteedEventBros.toggleEventSetting <- function (eventId, set100Percent)
{
	::GuaranteedEventBros.EventUtils.updateEvent(eventId, set100Percent);
}

// ::GuaranteedEventBros.fireTestEvent <- function ()
// {
// 	::logInfo("Firing a test event!");

// 	local eventManager = ::World.Events;
// 	local testEventIds = [
// 		"event.runaway_laborers",
// 		"event.thief_caught",
// 		"event.the_horseman"
// 	];

// 	if (this.World.Assets.getOrigin().getID() == "scenario.anatomists")
// 	{
// 		testEventIds.append("event.anatomist_helps_blighted_guy_1");
// 	}

// 	local selectedEventId = "";

// 	foreach (eventId in testEventIds) {
// 		local event = eventManager.getEvent(eventId);

// 		event.update();

// 		::logInfo("checking " + event.getTitle());

// 		if (event.m.Score == 0) {
// 			continue;
// 		}

// 		selectedEventId = eventId;
// 	}

// 	if (selectedEventId != "") {
// 		::logInfo("Trying to fire " + selectedEventId);
// 		eventManager.fire(selectedEventId);
// 	}
// }

::GuaranteedEventBros.HooksMod.queue(modLoadOrder, function() {
 	local mod = ::MSU.Class.Mod(::GuaranteedEventBros.ID, ::GuaranteedEventBros.Version, ::GuaranteedEventBros.Name);
	::GuaranteedEventBros.Mod <- mod;

	// ::GuaranteedEventBros.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.NexusMods, ::GuaranteedEventBros.NexusUrl);
	::GuaranteedEventBros.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, ::GuaranteedEventBros.GitHubUrl);
	::GuaranteedEventBros.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	::include("guaranteed_event_bros/normal_file_loading");
}); // ::Hooks.QueueBucket.Normal

::GuaranteedEventBros.HooksMod.queue(modLoadOrder, function() {
	::include("guaranteed_event_bros/first_world_file_loading");
}, ::Hooks.QueueBucket.FirstWorldInit);