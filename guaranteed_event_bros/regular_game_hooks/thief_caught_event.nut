::GuaranteedEventBros.HooksMod.hook("scripts/events/events/thief_caught_event", function(q) {
    q.onDetermineStartScreen = @(__original) function()
    {
		if (::GuaranteedEventBros.userGivesPermission("GuaranteeThiefCaught")) {
			::logInfo("Overriding Thief Caught logic to guarantee the bro joins.");
			return "A";
		}

		return __original();
    }
});