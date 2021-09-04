-- 1	Retrieve a list of the names of participants. 
SELECT Name
FROM participant;

-- 2 List the names of all participants who have enrolled in more than 2 weekly challenges. 
SELECT DISTINCT a.`Name`
FROM `participant` a, `participant-weeklychallenge` b
WHERE a.ParticipantID = b.ParticipantID 
AND b.`WeeklyChallengeID` > 2
GROUP BY `Name`, `WeeklyChallengeID`;

-- 3 What is the number of participants who have redeemed at least one “Car Wash at Caltex”?  
SELECT count(*) AS PartAmt
FROM `redemption` a, `reward` b
WHERE a.RewardID = b.RewardID 
AND `RewardName` = "Car Wash at Caltex";

-- 4 List the names of participants who have accumulated more than 10,000 SC points and have redeemed at least one “Car Wash at Caltex”?  
SELECT d.`Name`
FROM `redemption` a, `reward` b, `scpoint` c, `participant` d
WHERE a.RewardID = b.RewardID 
AND a.ParticipantID = c.ParticipantID
AND `RewardName` = "Car Wash at Caltex"
AND `BasicPointsEarned` > 10000;