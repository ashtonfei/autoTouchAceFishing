-- Screen size for iPhone 7+
local screenWidth = 1242
local screenHeight = 2208
-- colors
local white = 16777215
local red = 16711680
local black = 0
local blue = 2514580
-- Coordinates of start button
local startX = screenWidth / 2
local startY = 1800
local craftX = 808
local craftY = 1421
local guildX = 1070
local guildY = 1424
local sellX	= 821
local sellY = 1520
local tankX = 1084
local tankY = 1525
-- #####################################
function myTap(x, y)
touchDown(0, x, y)
usleep(20000)
touchUp(0, x, y)
end
function mySwipeToLeft(x, y, step)
touchDown(0,x,y)
for i = 1,10 do
sapce = x - step * i
usleep(3000)
touchMove(0, sapce, y)
end
touchUp(0, sapce, y)
end
function mySwipeToRight(x, y, step)
touchDown(0,x,y)
for i = 1,10 do
sapce = x + step * i
usleep(3000)
touchMove(0, sapce, y)
end
touchUp(0, sapce, y)
end
function mySwipeUp(x, y, step)
touchDown(0,x,y)
for i = 1,5 do
sapce = y - step * i
usleep(20000)
touchMove(0, x, sapce)
end
touchUp(0, x, sapce)
end
function fixGear()
-- Press fix button
while getColor(439,761) ~= white and getColor(362,968) ~= 4183295 do
usleep(5e5)
end
while getColor(439,761) == white do
myTap(439,761)
usleep(5e5)
end
-- Press fix with gold button
while getColor(213,573) ~= 2514580 do
usleep(5e5)
end
while getColor(213,573) == 2514580 do
myTap(632,1684)
usleep(5e5)
end
-- Press close button
while getColor(362,968) ~= 4183295 do
usleep(5e5)
end
while getColor(362,968) == 4183295 do
myTap(1068,493)
usleep(5e5)
end
end
function rodAndReelFix()
--if getColor(816,1280) == red or getColor(749,1279) == red then
if getColor(842,1272) == red or getColor(764,1272) == red then	-- Reel or Rod is exausted
log("Rod or Reel life is 0.")
while getColor(842,1272) == red or getColor(764,1272) == red do
myTap(529,1566)
usleep(5e5)
end
fixGear()
while getColor(549,1812) ~= white do
usleep(5e5)
end
myTap(startX,startY)
--log("Tapped...1")
elseif getColor(842,1311) == red then	-- Real and Rod are both exausted
log("Rod and Reel life are both 0.")
while getColor(842,1311) == red do
myTap(590,1567)
usleep(5e5)
end
while getColor(362,968) ~= 4183295 do
myTap(94,608)
usleep(5e5)
end
fixGear()
while getColor(549,1812) ~= white do
usleep(5e5)
end
myTap(startX,startY)
--log("Tapped...2")
end
end
function throwLure()
myTap(startX,startY)	--Press the start button
while getColor(600,1845) ~= white do	--Loop while "TAP" is not present
usleep(0.1e6)
rodAndReelFix()
end
usleep(0.3e6)
myTap(startX,startY)	--Press the start button to throw the bit
myTap(startX,startY)	--Press the start button again
end
function strike()
while #findColor(16771844,1,{239,129,50,20}) ~=1 do	--Loop while the yellow "100" in control panel is not present
usleep(0.1e6)
end
touchDown(0,startX,startY)
end
function backAndForth(sleepTime)
--while getColor(239,129) == 16771844 do	-- Loop while the yellow "100" in contorl panel is present
while #findColor(16771844,1,{239,129,50,20}) ==1 do	-- Loop while the yellow "100" in contorl panel is present
usleep(0.01e6)
if getColor(1067,270) == white then	--"HIGH"
touchUp(0,startX,startY)
usleep(sleepTime)
touchDown(0,startX,startY)
elseif getColor(305, 268) == white then	-- "LOW"
log("LOW is detected")
touchDown(0,startX,startY)
end
if getColor(601,1025) == white then	-- "Power strike"
--log("Power strike is detected")
touchUp(0,startX,startY)
usleep(sleepTime)
mySwipeUp(startX,startY,80)
touchDown(0,startX,startY)
usleep(1.5e6)
end
if getColor(545,989) == white then	-- "Left strike"
usleep(0.05e6)
mySwipeToLeft(startX,startY,50)
touchDown(0,startX,startY)
log("Left swipe is done")
end
if getColor(647,989) == white then	-- "Right strike"
--screenshot ("images/swipeRight1.bmp", nil)
usleep(0.05e6)
--screenshot ("images/swipeRight2.bmp", nil)
mySwipeToRight(startX,startY,50)
touchDown(0,startX,startY)
log("Right swipe is done")
end
end
touchUp(0,startX,startY)
end
function fullPack()
if getColor(292, 822) == 2514580 and getColor(591, 1364) == white then
log("Pack is full")
while getColor(591, 1364) == white do
myTap(591, 1364)
usleep(0.5e6)
end
end
end
function getReward()
if (getColor(639,809) == 55039 and getColor(575, 1717) == white) or (getColor(639, 726) == 55039 and getColor(575, 1824) == white) then	-- If the EYE of fish is detected
log("Reward is detected")
while getColor(639,809) == 55039 do
myTap(623,1720)
usleep(0.5e6)
end
while getColor(639, 726) == 55039 do
myTap(623, 1826)
usleep(0.5e6)
end
end
if getColor(203, 798) == 2514580 and getColor(571, 1370) then
while getColor(571, 1370) == white do
myTap(571,1370)
usleep(0.5e6)
end
end
end
function dailyMissionReward()
if getColor(138, 1382) == 8618883 and getColor(592, 1696) == white then
log("Daily mission reward is detected")
while getColor(592, 1696) == white do
myTap(592,1696)
usleep(0.5e6)
end
end
end
function limitedTimeReward()
if getColor(137, 316) == 2514580 and getColor(805, 1901) == white then
log("Limited time reward is detected")
while getColor(805, 1901) == white do
myTap(805, 1901)
usleep(0.5e6)
end
while getColor(589, 1365) ~= white do
usleep(0.5e6)
end
while getColor(589, 1365) == white do
myTap(589, 1365)
usleep(0.5e6)
end
while getColor(362, 1884) ~= white do
usleep(0.5e6)
end
while getColor(362, 1884) == white do
myTap(1092, 304)
usleep(0.5e6)
end
end
end
function buyHiddenLure()
if getColor(292, 1495) == 8650608 then
log("Hidden fish lure is detected")
while getColor(312, 1709) == 11466396 do
myTap(312, 1709)
usleep(0.5e6)
end
-- close the purchase info
while getColor(580, 1070) ~= 11861710 do
usleep(0.5e6)
end
while getColor(580, 1070) == 11861710 do
myTap(590, 1420)
usleep(0.5e6)
end
-- Confirm the purchase
while getColor(468,1101) ~= white and getColor(590,1365) ~= white do
usleep(5e5)
end
while getColor(590,1365) == white do
myTap(590,1365)
usleep(5e5)
end
end
end
function buyBigFishBooster()
if getColor(658, 1134) == 1177627 then
log("Big fish booster is detected")
while getColor(633, 1304) == 11466396 do
myTap(633, 1304)
usleep(0.5e6)
end
-- close the purchase info
while getColor(550, 1110) ~= 11861710 do
usleep(0.5e6)
end
while getColor(550, 1110) == 11861710 do
myTap(591, 1364)
usleep(0.5e6)
end
-- Confirm the purchase
while getColor(468,1101) ~= white and getColor(590,1365) ~= white do
usleep(5e5)
end
while getColor(590,1365) == white do
myTap(590,1365)
usleep(5e5)
end
end
end
function ashlyShop()
if getColor(187, 343) == 2514580 and getColor(647, 1912) == white and getColor(215, 717) == 16574581 then
buyHiddenLure()
buyBigFishBooster()
-- close the Ashly shop
while getColor(647, 1912) == white do
myTap(647, 1912)
usleep(0.5e6)
end
end
end
function randomReward()
if getColor(770, 1532) == 4671303 or getColor(800, 1540) == 4671303 then	-- If the random reward is detected
log("Random reward is detected")
while #findColor(4671303,1,{sellX,sellY,30,5}) == 1 do
myTap(startX,startY)
usleep(0.5e6)
end
end
getReward()
end
function wildFishFail()
if getColor(223, 1930) == white and getColor(493, 1083) == white and getColor(768, 1528) == 7731455 then
log("Wild fish fail is detected")
while getColor(223, 1930) == white do
myTap(startX,startY)
usleep(0.5e6)
end
end
end
function bigFishFail()
if getColor(493, 1083) == white and getColor(1082, 1728) == white then
log("Big fish fail is detected")
while getColor(1082, 1728) == white do
myTap(1082, 1728)
usleep(0.5e6)
end
end
end
function guild()
if getColor(guildX,guildY) == white then
while getColor(guildX,guildY) == white do
myTap(guildX,guildY)
usleep(0.5e6)
end
else
if getColor(tankX,tankY) == white or getColor(1025, 1524) == white then
while getColor(tankX,tankY) == white or getColor(1025, 1524) == white do
myTap(tankX,tankY)
usleep(0.5e6)
end
else
while #findColor(white,1,{sellX,sellY,30,3}) == 1 do
myTap(sellX,sellY)
usleep(0.5e6)
end
end
end
end
function craft()
if getColor(craftX,craftY) == white then	-- Craft:Yes
if getColor(guildX,guildY) == white then	-- Craft:Yes/Guild:Yes
while getColor(guildX,guildY) == white do
myTap(craftX,craftY)
usleep(0.5e6)
end
else	-- Craft:Yes/Guild:No
guild()
end
else
guild()
end
end
function fishCollect()
if getColor(770, 1532) == white or getColor(800, 1540) == white then
log("Facebook is detected")
while #findColor(white,1,{sellX,sellY,30,3}) == 1 do
craft()
--guild() -- Activate this line for guild fishing
ashlyShop()
getReward()
end
end
end
function rankUp()
if getColor(572, 1845) == white and getColor(520, 784) == 54782 then
while getColor(572, 1845) == white do
myTap(572,1845)
usleep(0.5e6)
end
end
end
function newRecord()
if getColor(523, 944) == 9830400 and getColor(582, 971) == white and getColor(621, 1155) == white then
while getColor(621, 1155) == white do
myTap(1016, 827)
usleep(0.5e6)
end
end
end
function fishHandling()
usleep(1e6)
repeat
usleep(0.5e6)
dailyMissionReward()
limitedTimeReward()
randomReward()
ashlyShop()
wildFishFail()
bigFishFail()
fishCollect()
fullPack()
rankUp()
newRecord()
until getColor(584, 1796) == white and getColor(172, 198) == white and getColor(653, 1802) == red
end
function goFishing()
log(tostring(getColor(161, 552)))
if getColor(549,1812) ~= white then	--"START" button is not present
log("You are in a wrong user interface!")
elseif getColor(172, 720) == white or getColor(172, 600) == 8618640 then
log("Pearl exp is full!")
else
--log("You are in a correct user interface!")
throwLure()
strike()
backAndForth(0.05e6)
fishHandling()
end
log("Fishing is done here...")
end
-- ########################################
goFishing()
-- #####################################
