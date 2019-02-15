package {
	import flash.display.MovieClip;//#tasks fix timing for first nanobot talkbox, make bosses permanent option, fix talkbox overflows
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	//import Event.ADDED_TO_STAGE;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.display.*;
	import flash.events.MouseEvent;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	//usual imports
	import segments.dragonflySegment;
	import segments.centipedeSegment;
	import soldiers.grenadier;
	import mutations.jawpiece;
	import mutations.centipedeArmor;
	import mutations.speedGhost;
	import props.sonicGrenade;
	import props.lava;
	import props.myMenu;
	import props.backGround;
	import props.unwalkable;
	import props.verticalPath;
	import props.horizontalPath;
	import props.leftPath;
	import props.rightPath;
	import props.upPath;
	import props.downPath;
	import props.chainsaw;
	import soldiers.chainsawer;
	import props.gore;
	import props.paleBlueField;
	import props.sprayedGore;
	import props.dropMeter;
	import props.sparks;
	import props.glowingRock;
	import buildings.centipedePool;
	import buildings.grenadeStation;
	import buildings.genesisPool;//#mispelling
	import menuStuff.slimeResource;
	import menuStuff.grenadeResource;
	import menuStuff.materialResource;
	import menuStuff.uraniumResource;
	import menuStuff.subCategorizer;
	import menuStuff.marketBars;
	import menuStuff.marketPanel;
	import menuStuff.tradeBox;
	import menuStuff.tradeButton;
	import props.corpse;
	import segments.rattleBug;
	import menuStuff.talkBox;
	import menuStuff.costDisplay;
	//specific imports
	public class documentClass extends MovieClip {
		public var frameCycle:int = 0;//frameCycle starts at zero
		public var cycleLength:int = 2310;//frameCycle wraps every 2310 frames
		// 2310 is divisible by first five primes: 1, 3, 5, 7, 11
		//use ctrl +f, #cycleDivide to find out what factors the cycleLength needs
		//remember to use modulus to divide up the whole cycle into sub-cycles
		//but only in methods themselves, not at the top level
		//consider replacing 2310 with 420
		//420 is divisble by 1,2,3,4,5,6,7,10,12,14,15,20,21,28,30,35,42,60,70,84,105,140,210,420
		//le marija-juana meme
		private var shouldPause = false;
		private var showMarket = false;
		private var clickPower: int = 2;
		private var maxedOut = false;
		private var subCategoryPower: int = 2;
		private var dropQuantity: int = 5;
		private var dropSize:int = 1;
		private var dropCost:int = 5;
		private var dropDuration:int= 1;
		//private var :int = 1;
		private var howMuchSlime:int = 1500;//#resources
		private var howMuchUranium:int = 1500;
		private var howMuchGrenade:int = 1500;
		private var howMuchMaterial:int = 1500;

		//costs
		//private var slimeRV:int = 1;//slime relative value
		//private var glowRV:int = 1;//glow relative value
		//private var uraniumRV:int = 1;//uranium relative value
		//private var materialRV:int = 1;//material relative value
		//mutation testing setup
		private var chainsawerSlimeCost = 1;


		private var wewew = " w e w \n e \n w ";
		private var ladad = " l a d \n a \n d ";
		// these are for stylized trace flares. No use outside of programming.
		public var dragonflies:Array = new Array();//list all dragonflies
		public var centipedes:Array = new Array();//list all centipede segments
		public var jawpieces:Array = new Array();
		public var rattlers:Array = new Array();
		public var speedGhosts:Array = new Array();
		public var leaders:Array = new Array();
		public var smokes:Array = new Array();
		public var sonicGrenades:Array = new Array();
		public var unwalkableTerrain:Array = new Array();
		public var chainSawers:Array = new Array();
		public var goreArray:Array = new Array();
		public var goreSprayArray:Array = new Array();
		public var corpseArray: Array = new Array();
		public var sparkArray:Array = new Array();
		public var centipedePoolArray:Array = new Array();
		public var sonicAffected:Array = new Array();
		public var glowingRocks:Array = new Array();
		public var adrenalineJunkies:Array = new Array();//#mutations
		public var youthJunkies:Array = new Array();
		public var experienceJunkies:Array = new Array();
		public var ageJunkies:Array = new Array();
		public var randomJunkies:Array = new Array();
		public var controlled:Array = new Array();
		public var initialTurrets:Array = new Array();
		//one setup values:
		public var minStageX = 0;
		public var minStageY = 800;
		public var maxStageX = 1100;
		public var maxStageY = 0;
		public var map = 0;//#mapEdit
		//one time things:
		var theMenu = new myMenu();
		var theBackground = new backGround();
		var mapTerrain = new unwalkable();
		var righteousHoriPath = new horizontalPath();
		var righteousVertPath = new verticalPath();
		var righteousUpPath = new upPath();
		var righteousDownPath = new downPath();
		var righteousLeftPath = new leftPath();
		var righteousRitePath = new rightPath();
		var paleBlueField1 = new paleBlueField();
		var dropQuantifier = new dropMeter(110,600,45,1);//#dropMeter #dropMeterEdit
		var dropSizer = new dropMeter(110,650,45,1);
		var longevityTimer = new dropMeter(60,650,45,1);
		var ourTradeButton = new tradeButton(43.4,355.3,55.9);
		var theTalkBox = new talkBox(547.0,421.8,267.4);//#talk #story
		var storyTimeCounter = 0;
		var storyTimes:Array = [0,0,0,0,0,0,0,0,0];//[6000,6000,1000,3000,3000,3000,3000,3000,3000];//[100,100,100,100,100,100,100,100,100];//;//
		var nextTrigger = 0;
		var currentStoryTarget;
		var nextTriggerType;
		//var dropTyper = new dropMeter(60,600,45,1);
		var categorizer = new subCategorizer(60,600,45,1);
		var slimeCounter = new slimeResource();
		var grenadeCounter = new grenadeResource();
		var uraniumCounter = new uraniumResource();
		var materialCounter = new materialResource();
		var upperTradeBox = new tradeBox(37.3,248.3,55);//#tradeBoxes
		var lowerTradeBox = new tradeBox(37.3,310.1,55);
		//level initialization
		var startYPoints:Array = new Array(127,417,671,918);//(711,704,708,702);
		var startXPoints:Array = new Array(127,417,671,918);
		var startDPoints:Array = new Array(-45,-45,-45,-45,-45,-45,-45,-45);// frame/level two
		var oneToOneSpawnPoints = false;
		var gameEnd:int;//0:kill all,1:kill boss,2:survive,3:build,4:capture,5:harvest
		var timeLimit:int;//survival succeeds at this point, other goals fail. In Minutes.
		var otherLimit;//0:kill all,1:bosses,2:deaths,3:buildings,4:specimens,5:resources
		var waves = new Array(4,1,4,1);//uncorrelated w/ gameEnd,0:smallCenti,1:largeCenti,2:lightBugs,3:bombBugs,4:rattlers
		var wavesRemaining:int = waves.length;
		var centipedeSmallWave:int = 15;
		var centipedeLargeWave:int = 5;//these are initial, subject to scaling//402.55,299.15,187.8,-138.4,-29.95,83.1,196.95,-256.4,-365.45,-27.35,287.2,398.8
		var rattlerWave:int = 3;//185.85,19.8,-188.2,19.8,-185.15,21.8,181.85,292.9,130.85,292.9,336.9,-188.1
		var centipedePoolSpawnsX:Array = [402.55,299.15,187.8,-138.4,-29.95,83.1,196.95,-256.4,-365.45,-27.35,287.2,398.8];
		var centipedePoolSpawnsY:Array = [185.85,19.8,-188.2,19.8,-185.15,21.8,181.85,292.9,130.85,292.9,336.9,-188.1];
		var mutationList:Array = ["antenae","armor","regeneration","speed"];
		var powerSourceList:Array = ["none","adrenaline","experience","longevity","maneating","youth"];
		var mutants:Array = new Array;
		var testPool1 = new genesisPool();
		var tutorialBoss = new rattleBug(testPool1.x,testPool1.y,55,Math.round(Math.random()*360),null,5,1,150 + Math.round((50 * Math.random())),true);
		//var slimeBar:marketBars = new marketBars(100,325,100,0xffffff);//#market
		//var uraniumBar:marketBars = new marketBars(120,325,100,0xff0000);
		//var glowBar:marketBars = new marketBars(140,325,100,0xff00ff);
		//var materialBar:marketBars = new marketBars(160,325,100,0x00ffff);

		var marketStuff = new Array();//#marketStuff
		var myMarketBars = new Array();
		var marketPanels = new Array();
		var marketPrices = new Array();//#marketPrices
		var costPanel = new costDisplay();
		//var tradeBoxes = new Array();//#tradeBox
		//My x position is 400.70000000000005and my y is -188
		//My x position is 402.55and my y is 185.85000000000002
		//My x position is 299.15000000000003and my y is 19.8
		//My x position is 187.8and my y is -188.20000000000002
		//My x position is -138.4and my y is 19.8
		//My x position is -29.950000000000003and my y is -185.15
		//My x position is 83.10000000000001and my y is 21.8
		//My x position is 196.95000000000002and my y is 181.85000000000002
		//My x position is -256.40000000000003and my y is 292.90000000000003
		//My x position is -365.45000000000005and my y is 130.85
		//My x position is -27.35and my y is 292.90000000000003
		//My x position is 287.2and my y is 336.90000000000003
		var stuffToAdd = new Array();
		var stuffToAddWhenPaused = new Array();
		public function documentClass() {
			//theTalkBox.storyText.selectable = false;
			//Erasable
			/*stuffToAdd.push(theBackground);
			stuffToAdd.push(mapTerrain);
			stuffToAdd.push(righteousHoriPath);
			stuffToAdd.push(righteousVertPath);
			stuffToAdd.push(righteousUpPath);
			stuffToAdd.push(righteousDownPath);
			stuffToAdd.push(righteousLeftPath);
			stuffToAdd.push(righteousRitePath);*/
			//neccesary
			stuffToAdd.push(dropQuantifier);
			stuffToAdd.push(paleBlueField1);
			paleBlueField1.alpha = 0;
			stuffToAdd.push(dropSizer);
			stuffToAdd.push(longevityTimer);
			//stage.addChildAt();//#market
			//stage.addChildAt(dropTyper,12);
			stuffToAdd.push(categorizer);
			stuffToAddWhenPaused.push(slimeCounter);//#resources
			stuffToAddWhenPaused.push(uraniumCounter);
			stuffToAddWhenPaused.push(materialCounter);
			stuffToAddWhenPaused.push(grenadeCounter);
			stuffToAdd.push(testPool1);
			stuffToAdd.push(costPanel);
			testPool1.x = 975;//genesis pool
			testPool1.y = 125;
			testPool1.height = 250;
			testPool1.scaleX = testPool1.scaleY;
			//stuffToAdd.push(lowerTradeBox);
			//stuffToAdd.push(upperTradeBox);
			//tradeBoxes.push(lowerTradeBox);
			//tradeBoxes.push(upperTradeBox);
			//tradeBoxes.push(ourTradeButton);
			marketStuff.push(lowerTradeBox);
			marketStuff.push(upperTradeBox);
			marketStuff.push(ourTradeButton);
			lowerTradeBox.addEventListener(MouseEvent.CLICK,changeInputResource);
			upperTradeBox.addEventListener(MouseEvent.CLICK,changeOutputResource);
			ourTradeButton.addEventListener(MouseEvent.CLICK,tradeResources);
			unwalkableTerrain.push(mapTerrain);
			stage.addEventListener("enterFrame", frameHandler);
			stage.addEventListener(MouseEvent.CLICK,clickHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyHandler);
			theMenu.addEventListener(KeyboardEvent.KEY_DOWN,keyHandler);
			delayTrigger(stage,MouseEvent.CLICK,firstTrigger);
			stage.focus=stage;
			for each (var addThis in stuffToAdd) {
				stage.addChildAt(addThis,stage.numChildren);
			}
			stage.addChildAt(theTalkBox,stage.numChildren);
			for (var e = 0; e < 5; e++) {//#market #marketStuff #marketPanel
				var appString;//appropriate string
				if (e == 0) {
					appString = " current market end in ";
				} else {
					appString = "  future market start in ";
				}
				var myMarketPanel = new marketPanel(71 + (e * 126),221.8,157.3,appString,e * 360);
				marketStuff.push(myMarketPanel);
				marketPanels.push(myMarketPanel);
			}
			for (var r = 0; r < 20; r++) {//#marketPrices
				var tempPrice;
				if (r < 4) {
					tempPrice = Math.round((Math.random() *10)+ 0.5);
					if (tempPrice > 10){
						tempPrice = 10;
					} else if (tempPrice < 1){
						tempPrice = 1;
					}
					marketPrices.push(tempPrice);
				} else {
					tempPrice = marketPrices[r - 4] + Math.round(5 * (Math.random() -0.5));
					marketPrices.push(tempPrice);
					if (marketPrices[r] < 1) {//safeguard
						marketPrices[r] = 1;
					} else if (marketPrices[r] > 10) {
						marketPrices[r] = 10;
					}
				}
			}
			//marketStuff.push(slimeBar);
			//marketStuff.push(uraniumBar);
			//marketStuff.push(materialBar);
			//marketStuff.push(glowBar);
			//var slimeBar:marketBars = new marketBars(100,325,100,0xffffff);//#market
			//var uraniumBar:marketBars = new marketBars(120,325,100,0xff0000);
			//var glowBar:marketBars = new marketBars(140,325,100,0xff00ff);
			//var materialBar:marketBars = new marketBars(160,325,100,0x00ffff);
			//
			var colorsOfMarketBar:Array = [0x00ffcc,0x00ff00,0x000000,0x00dddd];
			//should be length == bars per panel
			for (var t = 0; t < 20; t++) {//r max should be market panels times bars per panel
				var timeAround = (t - t % 4) / 4;
				var inputX = 100 + (t * 20) + (46 * (timeAround));//4 is bars per panel
				var tempBar:marketBars = new marketBars(inputX,325,100,colorsOfMarketBar[t % colorsOfMarketBar.length]);
				myMarketBars.push(tempBar);//#marketBars
				marketStuff.push(tempBar);
			}
			//for (var i:int = 0; i < 30; i++) {//#lava
//				var temp1 = new lava(stage.mouseX,stage.mouseY,5,(Math.random()*360)%360);
//				smokes.push(temp1);
//			}
			for (var o:int = 0; o < 120; o++) {
				var temp2 = new sonicGrenade(stage.mouseX,stage.mouseY,5,(Math.random()*360)%360);
				sonicGrenades.push(temp2);
			}
			for (var p:int =0; p < 120; p++) {
				var temp3 = new chainsawer(0,0,15,0,5,5,5);//#chainsawerEdit
				chainSawers.push(temp3);//#task enable infinite chainsawers
				controlled.push(temp3);
			}
			for (var q:int =0; q < centipedePoolSpawnsX.length; q++) {
				var temp4 = new centipedePool();//#centipedePoolEdit
				temp4.x = centipedePoolSpawnsX[q];
				temp4.y = centipedePoolSpawnsY[q];
				temp4.height = 120;
				temp4.scaleX = temp4.scaleY;
				centipedePoolArray.push(temp3);
				theBackground.addChildAt(temp4,theBackground.numChildren);
			}
			for (var w:int =0; w < 30; w++) {
				var temp5 = new glowingRock(0,0,15);
				temp5.alpha = 1;
				glowingRocks.push(temp5);//#task enable infinite chainsawers
			}
			for (var s:int =0; s<30;s++){
				var temp6 = new grenadeStation();
				temp6.alpha = 1;
				initialTurrets.push(temp6);
				//#return10
			}
			//#secondStage
			lowerTradeBox.tradeCounter.text = marketPrices[lowerTradeBox.currentFrame - 1];
			upperTradeBox.tradeCounter.text = marketPrices[upperTradeBox.currentFrame - 1];
			dropQuantifier.gotoAndStop(dropQuantity);
		}
		public function frameHandler(enterFrame) {
			//for each (var price in marketPrices){
			//trace("Price: ");
			//trace(price);
			//}
			//trace("endBlock");
			var firstCycle = true;
			if (frameCycle % 360 == 0) {//#marketPrices
				if (firstCycle) {
					firstCycle = false;
				} else {
					for (var i = 0; i < 20; i++) {
						if (i > 16) {
							marketPrices[i] = Math.round((Math.random() *10)+ 0.5);
							if (marketPrices[i] < 1) {//safeguard
								marketPrices[i] = 1;
							} else if (marketPrices[i] > 10) {
								marketPrices[i] = 10;
							}
						} else {
							marketPrices[i] = marketPrices[i + 4];
							if (marketPrices[i] < 1) {//safeguard
								marketPrices[i] = 1;
							} else if (marketPrices[i] > 10) {
								marketPrices[i] = 10;
							}
						}
					}
				}
			}
			slimeCounter.slimeText.text = howMuchSlime;//update counters #resources
			materialCounter.materialText.text = howMuchMaterial;
			grenadeCounter.grenadeText.text = howMuchGrenade;
			uraniumCounter.uraniumText.text = howMuchUranium;
			if (maxedOut == true){
				costPanel.costText.text = "maxed out"; 
			}else if (clickPower == 1){
				costPanel.costText.text = dropCost / dropDuration;
				costPanel.gotoAndStop(3);
			} else if (clickPower == 2){
				costPanel.costText.text = (10 * dropCost) / (dropDuration * dropSize);
				costPanel.gotoAndStop(2);
				//trace(dropCost / dropDuration);
			} else if (clickPower == 3){
				costPanel.costText.text = dropCost;
				costPanel.gotoAndStop(1);
			} else if (clickPower == 4){
				costPanel.costText.text = "no charge";
			} else if (clickPower == 5){
				costPanel.costText.text = 20 * dropCost / dropDuration;
				costPanel.gotoAndStop(4);
			} else if (clickPower == 6){
				costPanel.costText.text = "no charge";
			} else {
				costPanel.costText.text = "no charge";
			}//#costEdit
			
			//trace(sonicGrenades[1].height);
			if (testPool1.parent == stage) {//#genesisPool
				stage.removeChild(testPool1);//Keep things at the front
				stage.addChildAt(testPool1,stage.numChildren);
			}
			if (theTalkBox.parent == stage) {
				stage.removeChild(theTalkBox);//Keep things at the front
				stage.addChildAt(theTalkBox,stage.numChildren);
			}
			if (dropQuantifier.parent == stage) {
				stage.removeChild(dropQuantifier);//Keep things at the front
				stage.addChildAt(dropQuantifier,stage.numChildren);
			}
			if (dropSizer.parent == stage) {
				stage.removeChild(dropSizer);//Keep things at the front
				stage.addChildAt(dropSizer,stage.numChildren);
			}
			//if (dropTyper.parent == stage) {
			//stage.removeChild(dropTyper);//Keep things at the front
			//stage.addChildAt(dropTyper,stage.numChildren);
			//}
			if (categorizer.parent == stage) {//#restoration #restoration
				categorizer.gotoAndStop(clickPower);//((clickPower * 10) + subCategoryPower - 10);
				//trace((clickPower * 10) + subCategoryPower - 10);//#return1
				stage.removeChild(categorizer);//Keep things at the front
				stage.addChildAt(categorizer,stage.numChildren);
			}
			if (longevityTimer.parent == stage) {
				stage.removeChild(longevityTimer);//Keep things at the front
				stage.addChildAt(longevityTimer,stage.numChildren);
			}
			if (theMenu.parent == stage) {
				stage.removeChild(theMenu);
				stage.addChildAt(theMenu,stage.numChildren);
			}
			for each (var marketThing in marketStuff) {
				if (marketThing.parent == stage) {//#market #marketBars
					stage.removeChild(marketThing);
					stage.addChildAt(marketThing,stage.numChildren);
					var tempIndex = myMarketBars.indexOf(marketThing);
					if (tempIndex != -1) {
						marketThing.gotoAndStop(110 - (10 * marketPrices[tempIndex]));
					}
				}
			}
			for each (var marketPanel in marketPanels) {//#marketPanels
				if (marketPanel.parent == stage) {//#task convert to frames
					var tempNum = marketPanels.indexOf(marketPanel) * 4;//panel Index times four
					marketPanel.panelText.text = marketPrices[tempNum]+ "/" + marketPrices[tempNum + 1]+ "/" + marketPrices[tempNum + 2]+ "/" + marketPrices[tempNum + 3]+ marketPanel.appString + Math.round(((360 - (frameCycle % 360) + marketPanel.delay) /12)) + " seconds";
				}
			}
			if (paleBlueField1.parent == stage) {
				stage.removeChild(paleBlueField1);//Keep things at the front
				stage.addChildAt(paleBlueField1,stage.numChildren);
			}
			//for each (var contInst in controlled) {
			//
			//
			////#return3
			//}
			for each (var lacksSway in leaders) {
				if (lacksSway && lacksSway.mySway == null) {
					//trace(ladad);
					lacksSway.mySwaySize = 50 + Math.round(70 * Math.random());//#sway
					lacksSway.mySway = 0;
					lacksSway.swayVelocity = -3;
				}
			}
			if (shouldPause == false) {
				if (frameCycle < cycleLength) {// do cycle management
					frameCycle++;
				} else {
					frameCycle = 0;
				}
				if (frameCycle % 77 == 1 && wavesRemaining > 0) {// spawn new snek? Only if cycle mod (11 * 7) == 0
					//when adding new sneks/baddies, add if statements here! #task
					//adjust probability once testing over #task
					//createDragonflies();
					//#restore 77 //#waveSpacing #delayTime
					if (waves[wavesRemaining] == 0) {
						for (var p:int; p < centipedeSmallWave; p++) {
							createCentipede(0,0,1);
						}
					}
					if (waves[wavesRemaining] == 1) {//#waveEdit
						for (var o:int; o < centipedeLargeWave; o++) {
							createCentipede(5,5,1);
						}
					}
					//if (waves[wavesRemaining] == 4) {//#waveEdit
//						for (var i:int; i < rattlerWave; i++) {
//							createRattler(0,25,1);
//						}
//					}//#waves
					wavesRemaining -= 1;
					//trace(wavesRemaining);
				}
				updateSegments();
			}
		}
		public function clickHandler(MouseEvent) {//#powerEdit
			//sprayGore(stage.mouseX,stage.mouseY,stage,5);
			//trace("vert test:" + stage.mouseY);
			//trace("hori test:" + stage.mouseX);
			if (showMarket == false){
			var counter:int = 0;
			switch (clickPower) {//#restoration ((clickPower * 10) + subCategoryPower)
				case 1 ://11
					//dropGrenade(dropQuantity,dropSize,stage.mouseY,stage.mouseX,0.1);//#grenadeEdit
					for each (var grenade in sonicGrenades) {
			if (counter < dropQuantity && (howMuchGrenade >= (dropCost / (dropDuration)))) {//#sonicGrenadeCost #grenadeCost #cost1
				if (grenade != null) {
					if (grenade.gone == true) {
						grenade.x = stage.mouseX + (5 * (Math.random()-0.5));
						grenade.y = stage.mouseY + (5 * (Math.random()-0.5));//#task add #accuracy
						grenade.myExpire = 0.1;
						grenade.gotoAndStop(1);
						grenade.rotation= 0;
						grenade.height= 5 + 2*Math.pow(dropSize - 1, 1/2);
						grenade.scaleX = grenade.scaleY;
						grenade.play();//#return //6.95
						grenade.rotation = (Math.random()*360)%360;
						grenade.gone = false;
						stage.addChildAt(grenade,stage.numChildren);//#grenadeEdit #sonicGrenade
						
						howMuchGrenade -= dropCost / (dropDuration * dropQuantity);
						
						counter+=1;//#task fix pricing with grenade towers and normal grenades
					}
				} else {
					trace("NULL GRENADE DETECTED");
				}
			}
		}
		//trace(counter);
		if (counter == 0){//#return15
			maxedOut = true;
		} else {
			maxedOut = false;
		}







					break;
				case 2 ://12
					for each (var chainsawer in chainSawers) {
						if (counter < dropQuantity && (howMuchSlime >= ((10 * dropCost) / (dropDuration * dropSize)))) {//#chainsawerCost #cost2 //chainsawerSlimeCost
							if (chainsawer != null) {
								if (chainsawer.hp < 0) {
									chainsawer.x = stage.mouseX + (5 * (Math.random()-0.5));
									chainsawer.y = stage.mouseY + (5 * (Math.random()-0.5));//#accuracy
									//chainsawer.rotation = (Math.random()*360)%360;
									chainsawer.gotoAndPlay(1);
									this.scaleX = this.scaleY;
									chainsawer.hp = chainsawer.hpMax;
									chainsawer.rotation = Math.random() * 360;
									stage.addChildAt(chainsawer,stage.numChildren);//#chainsawerEdit
									counter+=1;
									howMuchSlime -= (10 * dropCost) / (dropDuration * dropSize * dropQuantity);//#slime #resources
								}
							} else {
								trace("NULL CHAINSAWER DETECTED");
							}
						}
					}
					//trace(counter);
		if (counter == 0){//#return15
			maxedOut = true;
		} else {
			maxedOut = false;
		}








					break;
				case 3 ://13
					for each (var rock in glowingRocks) {
						if (counter < dropQuantity && howMuchUranium >= (dropCost / (dropDuration * dropQuantity))) {//cost3
							if (rock != null) {
								if (rock.hp < 1) {
									rock.x = stage.mouseX + (5 * (Math.random()-0.5));
									rock.y = stage.mouseY + (5 * (Math.random()-0.5));//#accuracy
									//chainsawer.rotation = (Math.random()*360)%360;
									rock.gotoAndStop(1);
									this.scaleX = this.scaleY;
									rock.hp = 100;//#glowingRockEdit
									rock.height = 15 + 2*Math.pow(dropSize - 1, 1/2);
									rock.rotation = Math.random() * 360;
									stage.addChildAt(rock,5);//#glowingRock #rockEdit #radioactive
									rock.gotoAndPlay(16);
									counter+=1;
									if (testPool1.hitTestPoint(rock.x,rock.y)){
										stage.dispatchEvent(new Event("bossSpawned"));
										stage.dispatchEvent(new Event("addBoss"));
									}
									howMuchUranium -= (dropCost / dropDuration);//#cost3
								}
							} else {
								trace("NULL GLOWING ROCKS DETECTED");//#nullGlowingRocks
							}
						}
					}
					//trace(counter);
		if (counter == 0){//#return15
			maxedOut = true;
		} else {
			maxedOut = false;
		}













					break;
				case 4 ://14
					if (paleBlueField1.gone == true) {
						paleBlueField1.gone = false;
						paleBlueField1.alpha = 0;
						paleBlueField1.x = stage.mouseX;
						paleBlueField1.y = stage.mouseY;
					} else {
						paleBlueField1.alpha = 1;
						paleBlueField1.gone = true;
					}
					break;
				case 5 :
					for each (var tempTurret in initialTurrets) {//#cost5
						if (counter < 1 && (howMuchMaterial >= (dropCost / (dropDuration * dropSize)))) {
							if (tempTurret != null) {
								if (tempTurret.gone == true) {
									tempTurret.x = stage.mouseX + (5 * (Math.random()-0.5));
									tempTurret.y = stage.mouseY + (5 * (Math.random()-0.5));//#task add #accuracy
									tempTurret.gotoAndStop(1);
									tempTurret.rotation= 0;
									tempTurret.height= 50;//+ dropQuantity * 2*Math.pow(dropSize - 1, 1/2);
									tempTurret.scaleX = tempTurret.scaleY;
									tempTurret.play();//#return //6.95
									tempTurret.rotation = (Math.random()*360)%360;
									tempTurret.gone = false;
									for(var i = 0; i < dropQuantity;i++){
										var temp1Ghost = new speedGhost(tempTurret);
										tempTurret.myGhosts.push(temp1Ghost);
										tempTurret.myGhosts[i].x = tempTurret.x + Math.round(3 * (Math.random()-0.5));
										tempTurret.myGhosts[i].y = tempTurret.y + Math.round(3 * (Math.random()-0.5));
										tempTurret.myGhosts[i].rotation = Math.random() * 360;
										tempTurret.myGhosts[i].scaleX = tempTurret.myGhosts[i].scaleY;
										speedGhosts.push(tempTurret.myGhosts[i]);
										tempTurret.myGhosts[i].myMode = 1;
										stage.addChildAt(tempTurret.myGhosts[i],stage.numChildren);
										var temp3 = new sonicGrenade(stage.mouseX,stage.mouseY,5,(Math.random()*360)%360);
										sonicGrenades.push(temp3);
									}
									stage.addChildAt(tempTurret,stage.numChildren);//#grenadeEdit #sonicGrenade
									howMuchMaterial -= (dropCost / (dropDuration * dropSize));
									counter+=1;//#cost5 #turretCost #sonicTurretCost
								}
							} else {
								trace("NULL GRENADE DETECTED");
							}
						}
					}
					//trace(counter);
		if (counter == 0){//#return15
			maxedOut = true;
		} else {
			maxedOut = false;
		}

					break;
				case 6:
					wavesRemaining = 4;
					break;
				case 9://#readOut
					for each (var readMeOut in marketPrices){
						trace(readMeOut);
					}
			}
			
			//#return12
			//var counter:int = 0; //#task: re-enable lava, with some changes. Other lava-related tasks below
			//for each (var grenade in smokes) {
			//if (counter < 8) {
			//if (grenade != null) {
			//grenade.x = stage.mouseX + (25 * (Math.random()-0.5));
			//grenade.y = stage.mouseY + (25 * (Math.random()-0.5));
			//grenade.rotation = (Math.random()*360)%360;
			//grenade.gotoAndPlay(1);
			//grenade.height = Math.random() * 15;
			//this.scaleX = this.scaleY;
			//stage.addChildAt(grenade,0);//#grenadeEdit
			//counter+=1;
			//} else {
			//trace("NULL GRENADE DETECTED");
			//}
			//}
			//}
			////dropGrenade(20,20,stage.mouseX,stage.mouseY);
			
			}//if market is hidden && mouse clicked:
		}
		public function keyHandler(e:KeyboardEvent) {//#task sometime add a centipede that eats chainsawers and uses their armor
			//trace(e.keyCode);
			//trace(e.charCode);
			if (e.keyCode > 47 && e.keyCode < 58) {//#task add a key to manage resources
				if (clickPower != 1111 && subCategoryPower != 1111) {// if we are reseting
					clickPower = e.keyCode - 48;
					//subCategoryPower = 1111;
					//trace(clickPower);
				} /*else {// if only category n//#restoration
					subCategoryPower = e.keyCode - 48;//#return1
					//trace(categorizer.getChildAt());
				}*/
			}
			if (e.keyCode == 32) {
				if (shouldPause == true) {
					shouldPause = false;
					stage.removeChild(theMenu);
					//stage.removeChild(slimeCounter);
					for each (var marketThing2 in marketStuff) {
						if (marketThing2.parent == stage) {//#market
							stage.removeChild(marketThing2);
						}
					}
					showMarket = false;
					for each (var pauseThing1 in stuffToAddWhenPaused) {
						stage.removeChild(pauseThing1);
					}
					for each (var pausable in centipedes) {//#pause
						pausable.play();
					}
					for each (var pausable1 in jawpieces) {//#pause
						pausable1.play();
					}
					for each (var pausable2 in sonicGrenades) {//#pause
						pausable2.play();
					}
					for each (var pausable3 in chainSawers) {//#pause
						pausable3.play();
					}
					for each (var sprayedGore in goreSprayArray) {
						sprayedGore.play();
					}
					for each (var leTurret in initialTurrets) {
						leTurret.play();
					}
				} else {
					pauseEverything();
				}
			}
			if (e.charCode == 103) {
				if (showMarket == true && shouldPause == true) {
					for each (var marketThing in marketStuff) {
						if (marketThing.parent == stage) {//#market
							stage.removeChild(marketThing);
						}
					}
					showMarket = false;
				} else if (shouldPause == true){
					for each (var marketThing1 in marketStuff) {
						if (marketThing1.parent != stage) {//#market
							stage.addChildAt(marketThing1,stage.numChildren);
						}
					}
					showMarket = true;
				} else { //when g is pressed but unpaused
					pauseEverything();
					for each (var marketThing4 in marketStuff) {
						if (marketThing4.parent != stage) {//#market
							stage.addChildAt(marketThing4,stage.numChildren);
						}
					}
					showMarket = true;
				}
			}
			if (e.charCode == 119) {
				if (dropQuantity < 10) {
					dropQuantity += 1;
					dropCost = dropQuantity * dropSize * dropDuration;//#dropCost
				} else {
					dropQuantity = 1;
					dropCost = dropQuantity * dropSize * dropDuration;//#dropCost //#cost #sonicGrenadeCost #grenadeCost
				}
				dropQuantifier.gotoAndStop(dropQuantity);
				//trace(dropQuantity);
			}
			if (e.charCode == 100) {
				if (dropSize < 10) {
					dropSize += 1;
					dropCost = dropQuantity * dropSize * dropDuration;//#dropCost
				} else {
					dropSize = 1;
					dropCost = dropQuantity * dropSize * dropDuration;//#dropCost //#cost #sonicGrenadeCost #grenadeCost
				}
				dropSizer.gotoAndStop(dropSize);
				//trace(dropQuantity);
			}
			if (e.charCode == 120) {
				if (dropDuration < 10) {
					dropDuration += 1;
					dropCost = dropQuantity * dropSize * dropDuration;//#dropCost
				} else {
					dropDuration = 1;
					dropCost = dropQuantity * dropSize * dropDuration;//#dropCost //#cost #sonicGrenadeCost #grenadeCost
				}
				longevityTimer.gotoAndStop(dropDuration);
				//trace(dropQuantity);
			}
		}
		//public function createDragonflies() {
		//var leader:dragonflySegment = new dragonflySegment(250,250,50,90,null,10,1);
		//stage.addChild(leader);
		//dragonflies.push(leader);
		//var chainingChance:Number = 1.0;// 0.85
		//var linkTo:dragonflySegment = leader;//this changes while in loop so links are between followers
		//var randomRoll:Number = Math.random();//initial roll for multi segment
		//var minimumChaining = 5;//minimum segments = minimum chaining + added segments
		//var addSegments = 0;
		//while (randomRoll< chainingChance) {//add multi segment
		//var follower:dragonflySegment = new dragonflySegment(250,250,50,90,linkTo,10, Math.round(Math.random() * 9));
		//stage.addChild(follower);
		//dragonflies.push(follower);
		//follower.x -= Math.cos(((linkTo.rotation % 360)* Math.PI)/180)*(linkTo.height/5);
		//follower.y -= Math.sin(((linkTo.rotation % 360) * Math.PI)/180)*(linkTo.height/5);
		//chainingChance = (chainingChance * 17)/20;
		//randomRoll = Math.random();//reroll
		//if (randomRoll < chainingChance) {//will chain continue? if so,
		//linkTo = follower;//promotion!
		//minimumChaining -= 1;
		//} else if (minimumChaining > 0) {
		//linkTo = follower;
		//randomRoll = 0;
		//minimumChaining -= 1;
		//} else if (addSegments > 0) {
		//linkTo = follower;
		//randomRoll = 0;
		//addSegments  -= 1;
		//}
		//}// and loop to add more (unlikely) segments.
		////base probabilities on a scale that adjusts logarithmically with XP and time #task
		//}
		public function createCentipede(minimumChaining,addSegments,chainingChance) {//chainingChance == 0.85
			var sPI:int = Math.floor(startXPoints.length  * Math.random());//startPointIndex
			var sPIY:int;
			if (oneToOneSpawnPoints == true){
				sPIY = sPI;
			}else{
				sPIY = Math.floor(startYPoints.length  * Math.random());
			}
			//trace(startXPoints[sPI]);
//			trace(startYPoints[sPIY]);
			var leader:centipedeSegment = new centipedeSegment(startXPoints[sPI],startYPoints[sPIY],15,startDPoints[sPI],null,10,1,10,true);
			ethicalPush(leaders,leader);//#centipedeEdit
			var leaderJaw:jawpiece = new jawpiece(leader);//minimum segments = minimum chaining + added segments 55 #restore
			var tinted = false;
			if (Math.random() <0.1) {
				tinted = 0x00dddd;
				tintColor(leader, tinted, 0.4);
				tintColor(leaderJaw,tinted,0.4);
			}//#tintEdit
			stage.addChild(leaderJaw);//add segments  == 10 #restore
			stage.addChild(leader);
			centipedes.push(leader);
			jawpieces.push(leaderJaw);
			leader.myJaw = leaderJaw;//#centipedeEdit
			var linkTo:centipedeSegment = leader;//this changes while in loop so links are between followers //#hpEdit (second to last param)
			var randomRoll:Number = Math.random();//initial roll for multi segment
			while (randomRoll< chainingChance) {//add multi segment
				var follower:centipedeSegment = new centipedeSegment(startXPoints[sPI],startYPoints[sPIY],15,startDPoints[sPI],linkTo,10, Math.round(Math.random() * 9),5,true);
				stage.addChild(follower);
				if (tinted != false) {
					tintColor(follower, tinted, 0.4 + ((1 - Math.random())/2));
				}
				centipedes.push(follower);
				follower.x -= Math.cos(((linkTo.rotation % 360)* Math.PI)/180)*(linkTo.height/5);
				follower.y -= Math.sin(((linkTo.rotation % 360) * Math.PI)/180)*(linkTo.height/5);
				chainingChance = (chainingChance * 17)/20;
				randomRoll = Math.random();//reroll
				if (randomRoll < chainingChance) {//will chain continue? if so,
					linkTo = follower;//promotion!
					minimumChaining -= 1;
				} else if (minimumChaining > 0) {
					linkTo = follower;
					randomRoll = 0;
					minimumChaining -= 1;
				} else if (addSegments > 0) {
					linkTo = follower;
					randomRoll = 0;
					addSegments  -= 1;
				} else {
					follower.followMe = false;
				}
			}// and loop to add more (unlikely) segments.
			//base probabilities on a scale that adjusts logarithmically with XP and time #task
		}
		public function updateSegments() {
			//if (frameCycle % 420 == 0){
			//for each (var mutant in mutants){
			//trace(mutant.myMutations[1]);
			//}
			//}
			for each (var instance in dragonflies) {// for every dragonfly
				updateSegment(instance, 1.25,1,10,5);
			}
			for each (var instance1 in centipedes) {
				if (instance1 == null) {
					centipedes.splice(centipedes.indexOf(instance1));
				}//last here #restart
				updateSegment(instance1, 1.25, 1, 10, 50);
			}
			for each (var instance3 in jawpieces) {
				if (instance3.follows.hp < 1) {
					if (instance3.parent != null) {
						instance3.parent.removeChild(instance3);
					}
				} else {
					instance3.rotation = instance3.follows.rotation;
					instance3.x = instance3.follows.x;
					instance3.y = instance3.follows.y;
				}
			}
			//for each (var instance4 in smokes) { //#task: uncomment to re-enable lava.
			//if (instance4 != null) {//#grenadeEdit  //#task: change names to lava-related
			//for each (var segment in centipedes) {
			//if (instance4.hitTestObject(segment) && instance4.parent == stage && instance4.currentFrame > 25) {
			//instance4.commitEndBehavior();
			////#addDamage #task
			//}
			//}
			//if (Math.random()<0.001 && instance4.parent == stage) {
			//instance4.parent.removeChild(instance4);
			//}
			//} else {
			//trace("null smoke! #nullSmoke");//#nullSmoke
			//}
			//}
			for each (var instance5 in sonicGrenades) {
				if (instance5 != null) {//#sonicGrenadeEdit
					if (frameCycle % (1) == 0) {//#every now and then
						for each (var otherGrenade in sonicGrenades) {//give em some space
							if (otherGrenade.gone == false && otherGrenade.hitTestObject(instance5) && otherGrenade != instance5) {
								if (otherGrenade.x > instance5.x) {
									if (minStageX + (instance5.height/4) < instance5.x) {
										instance5.x -= instance5.height / 48;
									}
								} else {
									if (maxStageX - (instance5.height/4) > instance5.x) {
										instance5.x += instance5.height / 48;
									}
								}
								if (otherGrenade.y > instance5.y) {
									if (minStageY - (instance5.height/4) > instance5.y) {
										instance5.y -= instance5.height / 48;
									}
								} else {
									if (maxStageY + (instance5.height/4) < instance5.y) {
										instance5.y += instance5.height / 48;
									}
								}
							}
						}
					}
					for each (var segment in centipedes) {//#addDamage
						if (instance5.hitTestObject(segment) && instance5.parent == stage) {
							segment.rotation += Math.random() * 180;
							segment.x += Math.cos(((segment.rotation % 360)* Math.PI)/180)*(segment.height/5);
							segment.y += Math.sin(((segment.rotation % 360) * Math.PI)/180)*(segment.height/5);
							//segment.hp -= 1;
							//var centipedeColorTransform = new Color(0x66FFFF);
							if (Math.random() < 1.01) {
								var blue:Color = new Color();// #return
								blue.color = 0x66FFFF;
								//blue.setTint(0x66ffff, 0x000000);
								segment.transform.colorTransform = blue;
								sonicAffected.push(segment);
								if (segment.myJaw != null) {//if leader/has jaw
									segment.myJaw.transform.colorTransform = blue;
								}
								if (Math.random()<0.01 && (segment.hp < 1) != true) {//#goreEdit
									dropGore(segment.x,segment.y);
									if (segment.hp > 0) {
										sprayGore(segment.x,segment.y,stage,stage.numChildren,segment);
									}
								}
							}
						}
					}
					if (instance5.currentFrame == 23 && instance5.parent == stage && Math.random() < instance5.myExpire) {//always keep this current frame
						instance5.parent.removeChild(instance5);//CHANGE FRAME IF BROKEN
						instance5.gone = true;
					}
				} else {
					trace("null sonic! #nullSonic");//#nullSonic
				}
			}
			for each (var instance6 in chainSawers) {
				if (instance6 != null) {
					if (instance6.hp > 0) {//#chainsawerEdit
						if (frameCycle % (1) == 0) {//#every now and then
							for each (var teamMate in chainSawers) {//give em some space
								if (teamMate.hp > 0 && teamMate.hitTestObject(instance6) && teamMate != instance6) {
									if (teamMate.x > instance6.x) {
										instance6.x -= instance6.height / 99;
									} else {
										instance6.x += instance6.height / 99;
									}
									if (teamMate.y > instance6.y) {
										instance6.y -= instance6.height / 99;
									} else {
										instance6.y += instance6.height / 99;
									}
								}
							}
							if (instance6.x < (minStageX) || instance6.x > (maxStageX) || instance6.y > (minStageY) || instance6.y < (maxStageY)) {
								if (Math.random() < 0.5) {//#bounds
									instance6.rotation += 5;
								}
								instance6.x += Math.cos(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/30);
								instance6.y += Math.sin(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/30);
								if (instance6.x < minStageX) {
									instance6.x += instance6.height / 10;
								} else if (instance6.x > maxStageX) {
									instance6.x -= instance6.height / 10;
								} else if (instance6.y > minStageY) {
									instance6.y -= instance6.height / 10;
								} else {//instance6.y < (maxStageY - 20))
									instance6.y += instance6.height / 10;
								}
							}
						}
						if (paleBlueField1.hitTestPoint(instance6.x,instance6.y) && paleBlueField1.gone == false && instance6.target == false) {
							instance6.target = paleBlueField1;
						}//#chainsawerfield #fieldEdit
						var chainsawSightRange = 10;//if  target needs update //#task fix targeting for chainsawers//#distance
						if (instance6.target != paleBlueField1 && (instance6.target == false || (instance6.target.hp < 1 || chainsawSightRange <= Math.sqrt(Math.abs((instance6.x - instance6.target.x)^2 )+ Math.abs((instance6.y - instance6.target.y)^2))))) {
							for each (var segment1 in centipedes) {//#changeRange
								if (chainsawSightRange > Math.sqrt(Math.abs((instance6.x - segment1.x)^2 )+ Math.abs((instance6.y - segment1.y)^2)) && (segment1.hp > 0)) {
									instance6.target = segment1;
									if (Math.random() < 0.1) {//consider as target
										break;
									}
								} else {
									instance6.target = false;
								}//#task something something chainsawers gore
							}//#task add interactive chainsawers
							if (instance6.target == false){
								for each (var rattler1 in rattlers){//#changeRange #addDamage
								if (chainsawSightRange > Math.sqrt(Math.abs((instance6.x - rattler1.x)^2 )+ Math.abs((instance6.y - rattler1.y)^2)) && (rattler1.hp > 0)) {
									instance6.target = rattler1;
									if (Math.random() < 0.1){//consider as target
										break;
									}
							} else {
								instance6.target = false;
							}}
							}
						}
						if (instance6.target && instance6.target.hp < 1) {
							instance6.target = false;
						}
						if (instance6.target == false) {//no target, stand idle
							if (Math.random() < 0.5) {
								instance6.rotation += 1;
							}
							if (Math.random() < 0.5) {
								if (Math.random() < 0.5) {
									instance6.x += Math.cos(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/30);
								}
							} else {
								if (Math.random() < 0.5) {
									instance6.y += Math.sin(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/30);
								}
							}
							//var i = Math.random();
							//if (i < 0.3) {//#return
							//instance6.x += Math.cos(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/30);
							//instance6.y += Math.sin(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/30);
							//}
							//if (i < 0.1) {
							//instance6.rotation += (Math.random() -0.5) * 15;//#return
							//}
						} else if (instance6.target == paleBlueField1) {//#chainsawerfield #fieldEdit
							if (paleBlueField1.hitTestPoint(instance6.x,instance6.y) == false || paleBlueField1.gone == true) {
								instance6.target = false;
							} else {
								var temp = -180 * Math.atan2((instance6.x - instance6.target.x),(instance6.y - instance6.target.y)) / Math.PI;
								instance6.rotation = temp - 90;
								instance6.x += 1 *  Math.cos(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/15);
								instance6.y += 1 * Math.sin(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/15);
							}
							//#return3
						} else {//target acquired, seek and destroy
							if (instance6.target.hitTestObject(instance6.getChildAt(1))) {
								//if (instance6.target != false){trace(instance6.target.hp);}
								instance6.target.rotation += Math.random() * 3;//#task optimize the turn made by segments struck by chainsaws
								instance6.target.x += Math.cos(((instance6.target.rotation % 360)* Math.PI)/180)*(instance6.target.height/15);
								instance6.target.y += Math.sin(((instance6.target.rotation % 360) * Math.PI)/180)*(instance6.target.height/15);
								instance6.target.hp -= 1;
								if (Math.random()<0.1) {//#sprayGore
									//for (var i = 0; i < 5; i++) {
									sprayGore(instance6.target.x,instance6.target.y,stage,stage.numChildren,instance6.target);
									//}
								}
								//if (Math.random()<1) {
								////for (var i = 0; i < 5; i++) {
								//sprayGore(200,200,instance6,0);//#task figure out why this isn't showing up
								////}
								//}
							}
							//var temp = 180 - (180 * (Math.atan2((instance6.x - instance6.target.x),(instance6.y - instance6.target.y))/Math.PI));
							if (instance6.target.hitTestObject(instance6.getChildAt(1)) == false) {
								var temp1 = -180 * Math.atan2((instance6.x - instance6.target.x),(instance6.y - instance6.target.y)) / Math.PI;
								instance6.rotation = temp1 - 90;//#task fix chainsaws so that their fields work
								instance6.x += Math.cos(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/15);
								instance6.y += Math.sin(((instance6.rotation % 360)* Math.PI)/180)*(instance6.height/15);
							}
						}
						//if (instance6.currentFrame == 23 && instance6.parent == stage && Math.random() < 0.1) {//always keep this current frame
						//instance6.parent.removeChild(instance6);//CHANGE FRAME IF BROKEN
						//}
					}
				} else {
					trace("null chainsaw! #nullChainsaw");//#nullChainsaw
				}
			}
			for each (var instance7 in goreArray) {//#goreEdit
				if (instance7 != null && Math.random()<0.005 && instance7.parent == stage) {
					instance7.parent.removeChild(instance7);//#removeGore
					instance7.gone = true;
					howMuchSlime += 1;//#resources #slime
				}
			}
			for each (var instance8 in goreSprayArray) {//#sprayGoreEdit #goreSprayEdit
				//instance8.x += Math.cos(((instance8.rotation % 360)* Math.PI)/180);
				//instance8.y += Math.sin(((instance8.rotation % 360)* Math.PI)/180);
				if (instance8.follow) {
					instance8.x = instance8.follow.x;
					instance8.y = instance8.follow.y;
				}
				instance8.rotation += 5;
				//if (Math.random()<0.75) {
				instance8.progress += 1;
				//}
				if (instance8 && instance8.follow && instance8.follow.hp) {
					if (instance8.follow.hp < 1) {
						instance8.progress = 11;
					}
				}
				if (instance8.progress > 10) {
					if (instance8 != null && instance8.parent != null) {
						instance8.parent.removeChild(instance8);//#removeSparks
						instance8.gone = true;
						instance8.follow = null;
					}
				}
				//if (instance8.progress < 16) {
				//instance8.height += 1;
				//instance8.progress += 1;
				//} else if (instance8.progress < 32) {
				//instance8.height -= 1;
				//instance8.progress += 1;
				//} else {
				//if (instance8.parent == stage) {
				//instance8.parent.removeChild(instance8);
				//instance8.gone = true;
				//}
				//}
			}
			for each (var spark in sparkArray) {//#sparks #sparksEdit #spraySparks
				if (Math.random()<0.5) {
					spark.progress+= 1;
				}
				if (spark.progress > 20) {
					if (spark!= null && spark.parent != null) {
						spark.parent.removeChild(spark);//#removeSprayGore
						spark.gone = true;
					}
				}
			}
			for each (var shocked in sonicAffected) {
				if (shocked != null) {
					if (Math.random() < 0.01) {//allow shocked to go back to normal
						if (Math.random() < 0.1){
							shocked.hp -= 1;
						}
						var defaultTransform = new ColorTransform();
						shocked.transform.colorTransform = defaultTransform;// #task remove from list
						sonicAffected[shocked] = null;
						if (shocked.myJaw != null) {//if leader/has jaw
							shocked.myJaw.transform.colorTransform = defaultTransform;
						}
					}
				}
			}
			for each (var rock in glowingRocks) {
				if (rock != null) {//#glowingRockEdit
					if (Math.random() < 0.1) {
						rock.alpha = rock.hp / 100;
						rock.hp -= 1;
						if (rock.hp < 1 && rock.parent == stage) {
							stage.removeChild(rock);
						}
					}
					if (Math.random() < (rock.hp / 100)) {
						for each (var target in centipedes) {
							if (target.follows == null) {//if leader,
								if (target.hitTestObject(rock)) {//#mutants #mutations #mutationEdit
									if (target.myMutations.length < target.myMaxMutations) {
										target.myMutations.push(mutationList[Math.round((Math.random() * (mutationList.length - 1)))]);
										//trace(target.myMutations);
									}
									if (target.myRequirements.length < target.myMaxRequirements) {
										target.myRequirements.push(powerSourceList[Math.round((Math.random() * (powerSourceList.length - 1)))]);
										//trace(target.myRequirements);
									}//updateMutants(target);
								}
							}
						}
					}
					for each (var otherRock in glowingRocks) {//give em some space
						if (otherRock.hitTestPoint(rock.x,rock.y,true) && otherRock != rock) {
							if (otherRock.x > rock.x) {
								rock.x -= rock.height / 11;
							} else {
								rock.x += rock.height / 11;
							}
							if (otherRock.y > rock.y) {
								rock.y -= rock.height / 11;
							} else {
								rock.y += rock.height / 11;
							}
						}
					}
				}
			}
			//"antenae","armor","regeneration","speed"
			//"none","adrenaline","experience","longevity","maneating","youth"
			for each (var instance9 in rattlers){//#rattlers #rattleBugs
				//updateSegment(instance9,0.05,1,10,50);//1.25, 1, 10, 50
				//trace(instance9.hp);
				if (instance9.hp > 0 && instance9.parent == stage){
					instance9.x += Math.cos(((instance9.rotation)* Math.PI)/180);
					instance9.y += Math.sin(((instance9.rotation) * Math.PI)/180);
					boundMeUp(instance9);
					hurtMeUp(instance9,500);
				} else if ((instance9.hp > 0) == false){
					tintColor(instance9,0x000000,0.5);
					instance9.stop();
					stage.dispatchEvent(new Event("bossDied"));
					if (Math.random()<0.025 && instance9.parent){
						instance9.parent.removeChild(instance9);
					}
				} //#die //trace("boss in captivity");
			}
			for each (var instance10 in speedGhosts){//#speedGhosts #ghosts
				if(speedGhosts.indexOf(instance10) != -1){
					if (instance10.myMode == 1){//turret
						instance10.height = (50)/(Math.round(Math.sqrt(instance10.follows.currentFrame * 4)));
						instance10.scaleX = instance10.scaleY;
						if (instance10.follows.currentFrame==1){
							dropGrenade(1,1,instance10.y,instance10.x,0.5);
						}
						if (instance10.follows.height/6 > Math.sqrt(Math.abs((instance10.x - instance10.follows.x)^2 )+ Math.abs((instance10.y - instance10.follows.y)^2))){
							instance10.x += 2 *  Math.cos(((instance10.rotation)* Math.PI)/180);
							instance10.y += 2 *  Math.sin(((instance10.rotation) * Math.PI)/180);
							instance10.rotation += 5 * Math.round(Math.random());
						}else{
							instance10.rotation = (-180 * Math.atan2((instance10.x - instance10.follows.x),(instance10.y - instance10.follows.y)) / Math.PI) - 90;
							instance10.x += 2 * Math.cos(((instance10.rotation)* Math.PI)/180);
							instance10.y += 2 * Math.sin(((instance10.rotation) * Math.PI)/180);
						}
					} else {//normal
						if (instance10.follows.height / 9 > Math.sqrt(Math.abs((instance10.x - instance10.follows.x)^2 )+ Math.abs((instance10.y - instance10.follows.y)^2))){
							instance10.x += 5 *  Math.cos(((instance10.rotation)* Math.PI)/180);
							instance10.y += 5 *  Math.sin(((instance10.rotation) * Math.PI)/180);
							instance10.rotation += 5 * Math.round(Math.random());
						}else{
							instance10.rotation = (-180 * Math.atan2((instance10.x - instance10.follows.x),(instance10.y - instance10.follows.y)) / Math.PI) - 90;
							instance10.x += 5 * Math.cos(((instance10.rotation)* Math.PI)/180);
							instance10.y += 5 * Math.sin(((instance10.rotation) * Math.PI)/180);
						}
					}
				}
			}
			for each (var mutant in mutants) {//#mutations #mutationEdit #mutants
				for each (var reqTemp in mutant.myRequirements) {
					if (reqTemp == "none") {
						//#task:
						//updateMutantFollowers();
					}//change to init Mutants list, so initialization and refreshing can be sep
				}
				for each (var mutation in mutant.myMutations) {

				}
			}
			if (paleBlueField1.gone == false) {//#fieldEdit
				//trace(paleBlueField1.height);
				paleBlueField1.x = stage.mouseX;
				paleBlueField1.y = stage.mouseY;
				paleBlueField1.height = 50 * dropSize;//#return2
				paleBlueField1.scaleX = paleBlueField1.scaleY;
				paleBlueField1.alpha = 1;
			} else {
				paleBlueField1.x = -1000;
				paleBlueField1.y = -1000;
				//trace(Math.random());
			}
			for each (var removeableCorpse in corpseArray) {//#corpseEdit
				if (removeableCorpse.progress > 240 && removeableCorpse.parent && removeableCorpse.gone == false) {
					removeableCorpse.gone = true;
					removeableCorpse.parent.removeChild(removeableCorpse);
				} else {
					removeableCorpse.progress += 1;
				}
			}
		}
		public function updateSegment(instance,speed,c,spaceVariance,space) {// c is close: -1, none: 0, far: 1
			if (instance != null) {
				if (instance.hp < 1 && instance.parent) {
					if (instance.numChildren != 0 && Math.random() < 0.25) {//#corpse
						dropCorpse(instance.x,instance.y,0,instance.rotation);
					}
					dropGore(instance.x,instance.y);
					instance.parent.removeChild(instance);//remove crumpet
					instance.followMe = false;//#death #killed #murder #die #crumpet
				}
				if (instance.follows) {
					if (instance.follows.followMe == false || instance.follows.hp < 1) {
						instance.follows = null;//my master is dead
						instance.isThisFollowing = false;//independence at last
					}
				}
				if (instance.isThisFollowing != true) {//if head 
					if (paleBlueField1.hitTestPoint(instance.x,instance.y) && paleBlueField1.gone == false) {
						instance.target = paleBlueField1;
					} else if (instance.target == paleBlueField1) {
						instance.target = null;
					}else if (paleBlueField1.gone){
						instance.target = null;
					}
					if (instance.mySway > instance.mySwaySize || instance.mySway < (instance.mySwaySize * -1)) {
						instance.swayVelocity = instance.swayVelocity - (2 * instance.swayVelocity);//#sway
					}
					if (instance.mySway != null) {
						instance.mySway += instance.swayVelocity;
						instance.rotation += instance.swayVelocity;
					}
					//trace(instance.swayVelocity);
					//trace(instance.mySway);
					//trace(instance.mySwaySize);

					//trace("x: " + instance.x);
					//trace("y: " + instance.y);
					if (instance.fixAngle < 1) {//#centipedeBounds #bounds
						if (instance.x < (minStageX ) || instance.x > (maxStageX ) || instance.y > (minStageY ) || instance.y < (maxStageY)) {
							if (instance.fixAngle == 0) {
								if (Math.random() < 0.5) {
									instance.fixAngle = 18;
								} else {
									instance.fixAngle = -18;
								}
							}
							if (instance.x < minStageX) {
								instance.x += instance.height / 10;
							} else if (instance.x > maxStageX - 20) {
								instance.x -= instance.height / 10;
							} else if (instance.y > minStageY) {
								instance.y -= instance.height / 10;
							} else if (instance.y < (maxStageY)){
								instance.y += instance.height / 10;
							} else {
								trace("laddy you du ngoofed");
							}
						} else {
							var adjustRightNow = false;
							for each (var potentialBarrier in unwalkableTerrain) {
								if (potentialBarrier.hitTestPoint(instance.x + Math.cos(((instance.rotation)* Math.PI)/180)*(5 * instance.height/instance.speed),instance.y + Math.sin(((instance.rotation) * Math.PI)/180)*(5 * instance.height/instance.speed),true)) {
									adjustRightNow = true;
									break;
								}
							}
							if (adjustRightNow) {
								if ((Math.random() < 0.5 && instance.fixAngle == 0) || instance.fixAngle > 0) {
									instance.fixAngle = 36;
								} else {
									instance.fixAngle = -36;
								}
								instance.fixAngle += 2 * Math.round((Math.random() - 0.5));
							}
						}
						//trace(instance.fixAngle);
					}
					//trace("degree: " + instance.rotation);
					//trace("angle: " + instance.fixAngle);
					if (instance.fixAngle != 0) {//check if stuck
						//trace(instance.fixAngle);
						if (instance.fixAngle > 0) {
							instance.rotation = ((instance.rotation - 5 - Math.round(Math.random())) % 360);
							instance.fixAngle -= 1;
						} else {
							instance.rotation = ((instance.rotation + 5 + Math.round(Math.random())) % 360);
							instance.fixAngle += 1;
						}
						instance.curveMemory = 0;
						instance.x += speed * Math.cos(((instance.rotation)* Math.PI)/180)*(instance.height/instance.speed);
						instance.y += speed * Math.sin(((instance.rotation) * Math.PI)/180)*(instance.height/instance.speed);
						//if (instance.fixAngle < 1) {
						//instance.fixAngle = -36;
						//}
					} else {//finally, if nothing is actually wrong
						if (instance.target) {
							var xDirect = 0;
							var yDirect = 0;
							if (instance.x + 20 < instance.target.x) {
								xDirect = 1;
							}
							if (instance.x - 20 > instance.target.x) {
								xDirect = -1;
							}
							if (instance.y - 20 > instance.target.y) {
								yDirect = 1;
							}
							if (instance.y - 20 > instance.target.y) {
								yDirect = -1;
							}//#directionSensor (-180 * Math.atan2((instance.x - instance.target.x),(instance.y - instance.target.y)) / Math.PI)
							if (instance.rotation < (-180 * Math.atan2((instance.x - instance.target.x),(instance.y - instance.target.y)) / Math.PI)- 90) {
								instance.rotation += 4;
							} else if (instance.rotation > (-180 * Math.atan2((instance.x - instance.target.x),(instance.y - instance.target.y)) / Math.PI)-90) {
								instance.rotation -= 4;
							}
						}//#locomotion
						instance.x += speed *  Math.cos(((instance.rotation)* Math.PI)/180)*(instance.height/instance.speed);
						instance.y += speed *  Math.sin(((instance.rotation) * Math.PI)/180)*(instance.height/instance.speed);
						//these lines move the fellow along a hypotenuse of the triangle formed by his direction
						//START RIGHTEOUS PATHZ
						var deviance = 0;
						var hit = 0;
						if (righteousVertPath.hitTestPoint(instance.x,instance.y,true)) {
							if ((instance.rotation>0 && instance.rotation<90)||(instance.rotation > -180 && instance.rotation < -90)) {
								deviance += 1;
								hit = 1;
							}
							if ((instance.rotation<0 && instance.rotation>-90)||(instance.rotation < 180 && instance.rotation > 90)) {
								deviance -= 1;
								hit = 1;
							}//successfully more vertical
						}
						if (righteousHoriPath.hitTestPoint(instance.x,instance.y,true)) {
							if ((instance.rotation>0 && instance.rotation<90)||(instance.rotation > -180 && instance.rotation < -90)) {
								deviance -= 1;
								hit = 1;
							}
							if ((instance.rotation<0 && instance.rotation>-90)||(instance.rotation < 180 && instance.rotation > 90)) {
								deviance += 1;
								hit = 1;
							}//successfully more horizontal
						}
						if (righteousUpPath.hitTestPoint(instance.x,instance.y,true)) {
							if (instance.rotation>-90 && instance.rotation < 90) {
								deviance-=1;
								hit = 1;
							} else {
								deviance+=1;
								hit = 1;
							}//successfully more horizontal
						}
						if (righteousDownPath.hitTestPoint(instance.x,instance.y,true)) {
							if (instance.rotation>-90 && instance.rotation < 90) {
								deviance += 1;
								hit = 1;
							} else {
								deviance -= 1;
								hit = 1;
							}//successfully more horizontal 
						}
						if (righteousLeftPath.hitTestPoint(instance.x,instance.y,true)) {
							if (instance.rotation < 0) {
								deviance -= 1;
								hit = 1;
							} else {
								deviance += 1;
								hit = 1;
							}//successfully more horizontal
						}
						if (righteousRitePath.hitTestPoint(instance.x,instance.y,true)) {
							if (instance.rotation < 0) {
								deviance += 1;
								hit = 1;
							} else {
								deviance -=1;
								hit = 1;
							}//successfully more horizontal
						}
						if (hit == 0) {
							deviance += 10 * (0.5 - Math.random());//change rotation by how much
							instance.curveMemory += deviance;// #task : improve turning code.
						}
						if (frameCycle % 30 == 0) {
							var randomVar:Number = Math.random();
							if (randomVar < 0) {
								if (instance.curveMemory != 180) {
									instance.curveMemory = 0;
								}
							}
							if (Math.abs(instance.curveMemory) > 5 && (randomVar > 0.5 || instance.curveMemory == 180)) {
								if (instance.rotation > 0) {
									deviance += 15;
								} else {
									deviance -= 15;
								}
								if (Math.random() > 0.025) {
									if (Math.random() < 0.5) {
										instance.curveMemory = 180;
									} else {
										instance.curveMemory = -180;
									}
								} else {
									instance.curveMemory = 0;
								}
							}
						}
						instance.rotation += deviance;//implement
					}
				} else if (instance.hp > 0) {//if follower
					if (frameCycle % 6 == 0) {
						var temp = -180 * Math.atan2((instance.x - instance.follows.x),(instance.y - instance.follows.y)) / Math.PI;
						instance.rotation = temp - 90;
					}
					var slowX:Number = 0;
					if (c == -1 && space + Math.round(Math.random() * spaceVariance) < Math.abs(instance.follows.x - instance.x)) {//limit x movement
						slowX = speed;
					} else if (c == 1 && space + Math.round(Math.random() * spaceVariance) > Math.abs(instance.follows.x - instance.x)) {//limit x movement
						slowX = speed;// make sure that whatever this speed is, the leader moves at it
					} else {
						slowX = 1;
					}

					instance.x += slowX * Math.cos(((instance.rotation)* Math.PI)/180)*(instance.follows.height/instance.speed);
					var slowY:Number = 0;
					if (c == -1 && space + Math.round(Math.random() * spaceVariance) < Math.abs(instance.follows.y - instance.y)) {//limit x movement
						slowY = speed;// make sure that whatever this speed is, the leader moves at it
					} else if (c == 1 && space + Math.round(Math.random() * spaceVariance) > Math.abs(instance.follows.y - instance.y)) {
						slowY = speed;// make sure that whatever this number is, the leader moves at it
					} else {
						slowY = 1;
					}
					instance.y  += slowY * Math.sin(((instance.rotation) * Math.PI)/180)*(instance.follows.height/instance.speed);
				}
			}
		}
		//public function dropGrenade(size,smokes,xin,yin) {
		//for(var i:int = 0; i <= smokes; i++){;
		//var wew = new lava(xin,yin,size,(Math.random()*360)%360);
		//smokes.push(wew);
		//stage.addChild(wew);
		//}
		public function dropGore(xin,yin) {//#goreEdit
			//trace(xin);
			//trace(yin);
			for (var i = 0; i < 5; i++) {
				var failed = true;
				var tempGore;
				for (var j = 0; j < goreArray.length; j++) {
					if (goreArray[j].gone == true) {
						tempGore = j;
						failed = false;
						break;//#task #advanced Consider more efficient sorting methods, given that the sorting method itself makes future values of those it selects first less likely.
					}
				}
				if (failed) {
					tempGore = new gore(xin + (Math.random()- 0.5)* 15,yin + (Math.random()- 0.5)* 15,Math.random()*15, Math.round((Math.random() * 5) + 0.5));
					tempGore.gone = false;
					goreArray.push(tempGore);
					stage.addChildAt(tempGore,1);
				} else {
					goreArray[tempGore].gone = false;
					goreArray[tempGore].x = xin;
					goreArray[tempGore].y = yin;
					//goreArray[tempGore].push(tempGore);
					stage.addChildAt(goreArray[tempGore],1);
				}
			}
		}
		public function sprayGore(xin,yin,inputHost,layer,follow) {//#sprayGoreEdit
			//for (var i = 0; i < 5; i++) {
			var failed = true;
			var tempGore;
			var host = inputHost;
			if (inputHost == null) {
				host = stage;
			}
			for (var j = 0; j < goreSprayArray.length; j++) {
				if (goreSprayArray[j].gone == true) {
					tempGore = j;
					failed = false;
					break;//#task #advanced Consider more efficient sorting methods, given that the sorting method itself makes future values of those it selects first less likely.
				}
			}
			if (failed) {
				tempGore = new sprayedGore(xin,yin,3, Math.round((Math.random() * 6) + 0.5),follow);
				tempGore.gone = false;
				goreSprayArray.push(tempGore);
				host.addChildAt(tempGore,layer);
			} else {
				goreSprayArray[tempGore].gone = false;
				goreSprayArray[tempGore].progress = 0;
				//goreArray[tempGore].push(tempGore);
				host.addChildAt(goreSprayArray[tempGore],layer);
				goreSprayArray[tempGore].x = xin;
				goreSprayArray[tempGore].y = yin;
			}
			//}
		}
		public function spraySparks(xin,yin,inputHost,layer) {//#spraySparksEdit #sparks
			//for (var i = 0; i < 5; i++) {
			var failed = true;
			var tempSpark;
			var host = inputHost;
			if (inputHost == null) {
				host = stage;
			}
			for (var j = 0; j < sparkArray.length; j++) {
				if (sparkArray[j].gone == true) {
					tempSpark = j;
					failed = false;
					break;//#task #advanced Consider more efficient sorting methods, given that the sorting method itself makes future values of those it selects first less likely.
				}
			}
			if (failed) {
				tempSpark = new sparks(xin,yin,15, Math.round((Math.random() * 6) + 0.5));
				tempSpark.gone = false;
				sparkArray.push(tempSpark);
				host.addChildAt(tempSpark,layer);
				//trace(wewew);
			} else {
				sparkArray[tempSpark].gone = false;
				//goreArray[tempGore].push(tempGore);
				host.addChildAt(sparkArray[tempSpark],layer);
				sparkArray[tempSpark].x = xin;
				sparkArray[tempSpark].y = yin;
				//trace(ladad);
			}
			//}
		}
		public function tintColor(mc:Sprite, colorNum:Number, alphaSet:Number):void {//#reuse
			var cTint:Color = new Color();//thanks to jweeks123
			cTint.setTint(colorNum, alphaSet);
			mc.transform.colorTransform = cTint;
		}
		public function updateHeads(testFollower:centipedeSegment) {//#mutation //#return1
			var mutateSet;
			var requirementSet;
			var testDepth = 0;
			var exit = false;
			var lastTested = testFollower;
			while (exit != true) {
				if (lastTested.follows != null) {
					lastTested = lastTested.follows;//#optimize #advanced #task
				} else {
					mutateSet = lastTested.myMutations;
					requirementSet = lastTested.myRequirements;
					exit = true;
				}
			}
			testFollower.myMutations = mutateSet;
			testFollower.myRequirements = requirementSet;
		}
		public function updateMutants(mutantHead:centipedeSegment) {
			trace(mutantHead.myMutations);
			trace(mutantHead.myRequirements);
		}
		public function ethicalPush(leArray,leAddThing) {//le morales XD #ethicalPush #reuse
			var emptySpot = null;
			for (var i = 0; i < leArray.length; i++) {//#task #optimize #advanced Make it better XD
				if (leArray[i] == null) {
					emptySpot = i;
					break;
				}
			}
			if (emptySpot == null) {//no efficiency gain D:
				leArray.push(leAddThing);
			} else {
				leArray[emptySpot] = leAddThing;//yes so efficient XD
			}
		}
		public function dropCorpse(xin,yin,type,rotIn) {//#corpseEdit
			var failed = true;
			var tempCorpse;
			for (var j = 0; j < corpseArray.length; j++) {
				if (corpseArray[j].gone == true) {
					tempCorpse = j;
					failed = false;
					break;//#task #advanced Consider more efficient sorting methods, given that the sorting method itself makes future values of those it selects first less likely.
				}
			}
			if (failed) {
				tempCorpse = new corpse(xin,yin,15,rotIn);
				tempCorpse.gone = false;
				corpseArray.push(tempCorpse);
				stage.addChildAt(tempCorpse,5);
				tempCorpse.gotoAndStop((type + 1) * Math.round((Math.random() * 10) + 0.5));
			} else {
				corpseArray[tempCorpse].gone = false;
				corpseArray[tempCorpse].x = xin;
				corpseArray[tempCorpse].rotation = rotIn;
				corpseArray[tempCorpse].y = yin;
				corpseArray[tempCorpse].gotoAndStop((type + 1) * Math.round((Math.random() * 10) + 0.5));
				corpseArray[tempCorpse].progress = Math.round((Math.random() * 20) + 0.5);
				//goreArray[tempGore].push(tempGore);
				stage.addChildAt(corpseArray[tempCorpse],5);
			}
		}
		public function changeInputResource(e) {
			lowerTradeBox.gotoAndStop(((lowerTradeBox.currentFrame) % 4) + 1);
			lowerTradeBox.tradeCounter.text = marketPrices[lowerTradeBox.currentFrame - 1];
		}
		public function changeOutputResource(e) {
			upperTradeBox.gotoAndStop(((upperTradeBox.currentFrame) % 4) + 1);
			upperTradeBox.tradeCounter.text = marketPrices[upperTradeBox.currentFrame - 1];
		}
		public function tradeResources(e) {
			//#task3
			if (upperTradeBox.currentFrame - 1 == 0){//uranium, slime, grenades, material.
				howMuchUranium -= marketPrices[upperTradeBox.currentFrame - 1];
			}else if (upperTradeBox.currentFrame - 1 == 1){
				howMuchSlime -= marketPrices[upperTradeBox.currentFrame - 1];
			}else if (upperTradeBox.currentFrame - 1 == 2){
				howMuchGrenade -= marketPrices[upperTradeBox.currentFrame - 1];
			} else {
				howMuchMaterial -= marketPrices[upperTradeBox.currentFrame - 1];
			}
			if (lowerTradeBox.currentFrame - 1 == 0){
				howMuchUranium += marketPrices[lowerTradeBox.currentFrame - 1];
			}else if (lowerTradeBox.currentFrame - 1 == 1){
				howMuchSlime += marketPrices[lowerTradeBox.currentFrame - 1];
			}else if (lowerTradeBox.currentFrame - 1 == 2){
				howMuchGrenade += marketPrices[lowerTradeBox.currentFrame - 1];
			} else {
				howMuchMaterial += marketPrices[lowerTradeBox.currentFrame - 1];
			}
			//trace(marketPrices[upperTradeBox.currentFrame - 1]);
			//trace(marketPrices[lowerTradeBox.currentFrame - 1]);
		}
		public function createRattler(mutations,size,links) {
			for (var i = 0; i < links; i++) {
				var failed = true;
				var tempRattler;
				for (var j = 0; j < rattlers.length; j++) {
					if (rattlers[j].gone == true) {
						tempRattler = j;
						failed = false;
						break;//#task #advanced Consider more efficient sorting methods, given that the sorting method itself makes future values of those it selects first less likely.
					}
				}
				if (failed) {
					tempRattler = new rattleBug(711,127,55,0,null,3,1,1500,true);
					tempRattler.gone = false;
					rattlers.push(tempRattler);
					stage.addChildAt(tempRattler,5);
				} else {
					rattlers[tempRattler].gone = false;
					rattlers[tempRattler].x = 711;
					rattlers[tempRattler].rotation = 0;
					rattlers[tempRattler].y = 127;
					rattlers[tempRattler].hp = 15;
					stage.addChildAt(rattlers[tempRattler],5);
				}
			}
		}
		public function firstTrigger(e) {//#ptsd #triggered XDDDddd
			stage.removeEventListener(MouseEvent.CLICK,firstTrigger);
			theTalkBox.dialogue.text = "Don't worry about us; we've trained for this.[press spacebar to pause and unpause the game. You can add soldiers (limit 120) while paused. Try it out!]";
			theTalkBox.gotoAndStop(1);
			delayTrigger(stage,KeyboardEvent.KEY_DOWN,secondTrigger);
			stage.addChildAt(theTalkBox,stage.numChildren);
		}
		public function secondTrigger(e) {
			//trace(e.charCode);
			if (e.charCode == 32) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,secondTrigger);
				theTalkBox.dialogue.text = "In actual combat slime would be collected and sold for useful resources. But here, we spare no expense. [press G to show market. Effects don't work in market.]";
				theTalkBox.gotoAndStop(2);
				//trace("secondtirgger");
				stage.addChildAt(theTalkBox,stage.numChildren);
				delayTrigger(stage,KeyboardEvent.KEY_DOWN,thirdTrigger);
			}
		}
		public function thirdTrigger(e) {
			//trace(e.charCode);
			if (e.charCode == 103) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,thirdTrigger);
				theTalkBox.y += 95;
				theTalkBox.gotoAndStop(2);
				stage.addChildAt(theTalkBox,stage.numChildren);
				theTalkBox.dialogue.text = "Click the trade-boxes on the left to change what you are willing to trade (upper box) and what you want in exchange (lower box). Click trade before the market changes!";
				delayTrigger(stage,MouseEvent.CLICK,fourthTrigger);
			}
		}
		public function fourthTrigger(e) {
			//trace(e.charCode);
				stage.removeEventListener(MouseEvent.CLICK,fourthTrigger);
				theTalkBox.gotoAndStop(2);
				stage.addChildAt(theTalkBox,stage.numChildren);
				theTalkBox.dialogue.text = "Those seconds on the market count down whenever the game is playing- the bars are the prices of radioactive waste, slime, grenades, and building material.";
				delayTrigger(stage,KeyboardEvent.KEY_DOWN,fifthTrigger);
		}
		public function fifthTrigger(e){
			if(e.charCode == 103 || e.charCode == 32){
				theTalkBox.gotoAndStop(4);
				stage.addChildAt(theTalkBox,stage.numChildren);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,fifthTrigger);
				theTalkBox.dialogue.text = "It isn't that fun to kill centipedes, you need a real challenge. When you are finished buying low and selling high, press 3 and click on the genesis chamber.";
				dropQuantity = 1;
				dropSize = 1;
				dropCost = dropQuantity * dropSize * dropDuration;//#cost
				dropSizer.gotoAndStop(1);
				dropQuantifier.gotoAndStop(1);
				delayTrigger(stage,"bossSpawned",sixthTrigger);
				stage.addEventListener("addBoss",bossTriggered);
				stage.focus = stage;
			}
		}
		public function sixthTrigger(e){
			theTalkBox.gotoAndStop(3);
			stage.addChildAt(theTalkBox,stage.numChildren);
			stage.removeEventListener("bossSpawned",sixthTrigger);//#bossSpawned
			theTalkBox.dialogue.text = "I calculate ballistics for aerial bombing. Press 1 to command my grenade barrage. [adjust bomb size with W key, quantity with D key. X does nothing for my barrage.]";
			delayTrigger(stage,MouseEvent.CLICK,seventhTrigger);
		}
		public function seventhTrigger(e){
			theTalkBox.gotoAndStop(5);
			stage.addChildAt(theTalkBox,stage.numChildren);
			theTalkBox.dialogue.text = "If you need more firepower, press five and we will help you assemble grenade turrets- for a price. [D increases bomb rate, W and X do nothing for towers.]";
			//dropQuantity = 1;
			//dropSize = 1;
			//delayTrigger(stage,"bossSpawned",sixthTrigger);
			//stage.focus = stage;
			delayTrigger(stage,"bossDied",eightTrigger);
			stage.removeEventListener(MouseEvent.CLICK,seventhTrigger);
		}
		public function eightTrigger(e){
			stage.removeEventListener("bossDied",eightTrigger);
			theTalkBox.dialogue.text = "Good job. Not everything comes with a price tag. Press 6 and click for more centipedes. Press 4 for a soldier/centipede guiding field.";
		}
	public function delayTrigger(inTarget,inType,inTrigger){//#story
		currentStoryTarget = inTarget;
		nextTrigger = inTrigger;
		nextTriggerType = inType;
		//trace(storyTimes[storyTimeCounter]);
		if (theTalkBox.parent){
			//trace("test");
			theTalkBox.parent.removeChild(theTalkBox);
		}
		var tempTimer = new Timer(storyTimes[storyTimeCounter],1);//#storyedit
		storyTimeCounter+=1;
		//trace("starting timer");
		tempTimer.start();
		//trace("started timer");
		tempTimer.addEventListener(TimerEvent.TIMER_COMPLETE,delayedAdd);
	}
	public function delayedAdd(e){
		//tempTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,delayedAdd);
		currentStoryTarget.addEventListener(nextTriggerType,nextTrigger);
		//trace(theTalkBox.parent);
		if (theTalkBox.parent == null){stage.addChildAt(theTalkBox,stage.numChildren);}
		//stage.removeChild(theTalkBox);
	}
		//I calculate ballistics for aerial bombardments. Press 1 twice to command my barrage. [adjust size with W key, quantity with D key]
	public function dropGrenade(inQuantity,inSize,yin,xin,inExpire){
		var counter = 0;
		for each (var grenade in sonicGrenades) {
			if (counter < inQuantity) {//#sonicGrenadeCost #grenadeCost #cost1
				if (grenade != null) {
					if (grenade.gone == true) {
						grenade.x = xin + (5 * (Math.random()-0.5));
						grenade.y = yin + (5 * (Math.random()-0.5));//#task add #accuracy
						grenade.myExpire = inExpire;
						grenade.gotoAndStop(1);
						grenade.rotation= 0;
						grenade.height= 5 + 2*Math.pow(inSize - 1, 1/2);
						grenade.scaleX = grenade.scaleY;
						grenade.play();//#return //6.95
						grenade.rotation = (Math.random()*360)%360;
						grenade.gone = false;
						stage.addChildAt(grenade,stage.numChildren);//#grenadeEdit #sonicGrenade
						//howMuchGrenade -= dropCost / (dropDuration * dropQuantity);
						
						counter+=1;//#task fix pricing with grenade towers and normal grenades
					}
				} else {
					trace("NULL GRENADE DETECTED");
				}
			}
		}
		//trace(counter);
		if (counter == 0){//#return15
			maxedOut = true;
		} else {
			maxedOut = false;
		}
	}
	public function boundMeUp(me){//#bounds #task implement where relevant (ctrl + f + maxStageY)
		if (me.fixAngle > 5) {
			me.rotation -= 5;
			me.fixAngle -= 5;
		} else if (me.fixAngle < -5){
			me.rotation += 5;
			me.fixAngle += 5;
		} else {
			me.fixAngle = 0
			me.rotation += me.fixAngle * -1;
		}
		if (me.x < (minStageX ) || me.x > (maxStageX ) || me.y > (minStageY ) || me.y < (maxStageY)) {
				me.rotation += 25;
				if (me.fixAngle == 0) {
					if (Math.random() < 0.5) {
						me.fixAngle = 36;
					} else {
						me.fixAngle = -36;
					}
				}
				if (me.x < minStageX) {//#task improve customizibablity of function- recoil, turning, etc.
					me.x += me.height / 10;
				} else if (me.x > maxStageX - 20) {
					me.x -= me.height / 10;
				} else if (me.y > minStageY) {
					me.y -= me.height / 10;
				} else if (me.y < (maxStageY)){
					me.y += me.height / 10;
				} else {
					trace("laddy you du ngoofed");
				}
			}
		}
		public function hurtMeUp(me,weight:int = 5){
			var nowHurt = false;
			for each (var hurtfulThing in sonicGrenades)
			if (hurtfulThing.hitTestObject(me) && hurtfulThing.parent == stage && nowHurt == false) {
							me.rotation += (Math.random() - 0.5) * (360);
							me.x += Math.cos(((me.rotation % 360)* Math.PI)/180)*(me.height/weight);
							me.y += Math.sin(((me.rotation % 360) * Math.PI)/180)*(me.height/weight);
							//segment.hp -= 1;
							//var centipedeColorTransform = new Color(0x66FFFF);
							if (Math.random() < 1.01) {
								var blue:Color = new Color();// #return
								blue.color = 0x66FFFF;
								//blue.setTint(0x66ffff, 0x000000);
								me.transform.colorTransform = blue;
								sonicAffected.push(me);
								nowHurt = true;
								if (me.myJaw != null) {//if leader/has jaw
									me.myJaw.transform.colorTransform = blue;
								}
								if (Math.random()<0.01 && (me.hp < 1) != true) {//#goreEdit
									dropGore(me.x,me.y);
									if (me.hp > 0) {
										sprayGore(me.x,me.y,stage,stage.numChildren,me);
									}
								}
							}
						}
		}
		public function bossTriggered(e){
			if (tutorialBoss.parent != stage){
				stage.addChildAt(tutorialBoss,stage.numChildren);//#tutorialBoss
				rattlers.push(tutorialBoss);
				tutorialBoss.x = testPool1.x;
				tutorialBoss.y = testPool1.y;
				tutorialBoss.rotation = 0;
				tutorialBoss.height = 55;
				tutorialBoss.rotation = Math.round(Math.random()*360);
				tutorialBoss.hp = 150 + Math.round((50 * Math.random()));
				tutorialBoss.speed = 5;
				
				if (tutorialBoss.hasGhosts == false){
					for (var i = 0; i<5; i++){
						var tempGhost = new speedGhost(tutorialBoss);
						stage.addChildAt(tempGhost,stage.numChildren);
						tempGhost.x = tutorialBoss.x;
						tempGhost.y = tutorialBoss.y;
						tempGhost.height = 5;
						tempGhost.scaleX = tempGhost.scaleY;
						speedGhosts.push(tempGhost);
					}
					tutorialBoss.hasGhosts = true;
				}
				//tutorialBoss.myMutations[0] = mutationList[Math.round(Math.random() * mutationList.length)];
				//trace(tutorialBoss.myMutations[0]);
				//tutorialBoss.;
			}
		}
		public function pauseEverything(){
			shouldPause = true;
			stage.addChildAt(theMenu,stage.numChildren);
			theMenu.gotoAndPlay(1);
			for each (var pauseThing in stuffToAddWhenPaused) {
				stage.addChildAt(pauseThing,stage.numChildren);
			}
			//stage.addChild(slimeCounter);
			for each (var pausable4 in centipedes) {//#UNPAUSE ALL
				pausable4.stop();
			}
			for each (var pausable5 in jawpieces) {//#unpause #jaws
				pausable5.stop();
			}
			for each (var pausable6 in sonicGrenades) {//#unpause #sonicGrenades
				pausable6.stop();
			}
			for each (var pausable7 in chainSawers) {//#unpause #chainSawers
				pausable7.stop();
			}
			for each (var sprayedGore1 in goreSprayArray) {
				sprayedGore1.stop();
			}
			for each (var leTurret1 in initialTurrets) {
				leTurret1.stop();
			}
		}
	}
	//#spriteSheet
	//Locations: Moss brick @verticalPath
}//#task add more resources
//#task add centipede skins that are shed to form hives
//#task implement ethicalPush in more places
//#task fix gore errors //?completed? //no not yet
//#task add boss fights