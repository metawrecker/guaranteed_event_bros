::GuaranteedEventBros.EventUtils <- {
	m = {
		BlightedGuy = {
			ScreenIndex = 0,
			OptionsIndex = 0,
			Modded = {
					ModdedOutput = true,
					Text = "[100%] In that case we\'re going to help him.",
					function getResult( _event )
					{
						return "B";
					}
				},
			Vanilla = {
					Text = "In that case we\'re going to help him.",
					function getResult( _event )
						{
							return this.Math.rand(1, 100) <= 50 ? "B" : "C";
						}
			}
		},
		RunawayLaborers = {
			ScreenIndex = 0,
			OptionsIndex = 1,
			Modded = {
				ModdedOutput = true,
				Text = "[100%] We haven\'t seen anyone around these parts.",
				function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);

						if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
						{
							return "C";
						}
						else
						{
							return this.Math.rand(1, 100) <= 70 ? "E" : "D";
						}
					}
			},
			Vanilla = {
				Text = "We haven\'t seen anyone around these parts.",
				function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);

						if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
						{
							return this.Math.rand(1, 100) <= 70 ? "C" : "D";
						}
						else
						{
							return this.Math.rand(1, 100) <= 70 ? "E" : "D";
						}
					}
			}
		},
		ThiefCaught = {
			ScreenIndex = 3,
			OptionsIndex = 0,
			Modded = {
				ModdedOutput = true,
				Text = "[100%] Not everyone will be this lenient...",
				function getResult( _event )
					{
						if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
						{
							return 0;
						}
						else
						{
							return "E";
						}
					}
			},
			Vanilla = {
				Text = "Not everyone will be this lenient...",
				function getResult( _event )
					{
						if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax() || this.Math.rand(1, 100) <= 25)
						{
							return 0;
						}
						else
						{
							return "E";
						}
					}
			}
		},
		TheHorseman = {
			ScreenIndex = 1,
			OptionsIndex = 0,
			Modded = {
				ModdedOutput = true,
				Text = "[100%] We\'ll cut you down.",
				function getResult( _event )
					{
						return "C";
					}
			},
			Vanilla = {
				Text = "We\'ll cut you down.",
				function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 75)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}
			}
		}
	},

	function onGameLoad()
	{
		 try {
			local eventList = ::World.Events.m.Events;

			if (!eventList) {
				::logError("No events in the event manager right now...");
				return;
			}

			for(local i = 0; i < eventList.len(); i = ++i)
			{
				local currentEventId = eventList[i].getID();
				local currentEventScreens = eventList[i].m.Screens;

				if (currentEventId == "event.anatomist_helps_blighted_guy_1") {
					modifyEvent(currentEventId, currentEventScreens, ::GuaranteedEventBros.userGivesPermission("GuaranteeBlightedGuy"));
				}
				else if (currentEventId == "event.runaway_laborers") {
					modifyEvent(currentEventId, currentEventScreens, ::GuaranteedEventBros.userGivesPermission("GuaranteeRunawayLaborers"));
				}
				else if (currentEventId == "event.thief_caught") {
					modifyEvent(currentEventId, currentEventScreens, ::GuaranteedEventBros.userGivesPermission("GuaranteeThiefCaught"));
				}
				else if (currentEventId == "event.the_horseman") {
					modifyEvent(currentEventId, currentEventScreens, ::GuaranteedEventBros.userGivesPermission("GuaranteeTheHorseman"));
				}
			}

		} catch (exception){
			::logError(exception)
			// show error to user??
		}
	}

	function updateEvent(eventId, set100Percent)
	{
		try {
			local eventList = ::World.Events.m.Events;

			if (!eventList) {
				::logError("No events in the event manager right now...");
				return;
			}

			for(local i = 0; i < eventList.len(); i = ++i)
			{
				local currentEventId = eventList[i].getID();
				local currentEventScreens = eventList[i].m.Screens;

				if (currentEventId == eventId) {
					modifyEvent(currentEventId, currentEventScreens, set100Percent);
				}
			}
		} catch (exception){
			::logError(exception)
			// show error to user??
		}
	}

	function modifyEvent(eventId, eventScreens, set100Percent) //eventScreens should be updated since squirrel arrays are passed by ref
	{
		local eventContent = {};
		local newContent = {};
		local logText = "vanilla chance";

		switch (eventId) {
			case "event.anatomist_helps_blighted_guy_1":
				eventContent = this.m.BlightedGuy;
				break;
			case "event.runaway_laborers":
				eventContent = this.m.RunawayLaborers;
				break;
			case "event.thief_caught":
				eventContent = this.m.ThiefCaught;
				break;
			case "event.the_horseman":
				eventContent = this.m.TheHorseman;
				break;
		}

		if (eventContent.len() == 0) {
			::logError("Could not match event content with event");
			return;
		}

		if (set100Percent) {
			newContent = eventContent.Modded;
			logText = "100% chance"
		}
		else {
			newContent = eventContent.Vanilla;
		}

		::logInfo("Updating event: " + eventId + " to " + logText);

		eventScreens[eventContent.ScreenIndex].Options[eventContent.OptionsIndex] = newContent

		if ("ModdedOutput" in eventScreens[eventContent.ScreenIndex].Options[eventContent.OptionsIndex] &&
			eventScreens[eventContent.ScreenIndex].Options[eventContent.OptionsIndex].ModdedOutput == true) {
			::logInfo("Confirmed event has been updated to modded setting.");
		}
	}
}