-- 1.	List the names of users who are group moderators.  
    select name
    from user
    where UserID IN
    (
          select UserID
          from `user-group`
          where isModerator = 'Y' );
          
-- 2.	List the names of users who are banned in more than 1 group.
    select name
    from user
    where UserID IN
    (
          select UserID
          from `user-group`
          where isBanned = 'Y' );

-- 3. 	List the names of users and total filesize of each user’s photos when the total filesize 
-- of his/her photos is larger than 1000.
SELECT name, sum(filesize) AS Total_Photo_Filesize
FROM `user`, `photo`, `user-photo`
WHERE `user`.UserID = `user-photo`.UserID and `user-photo`.PhotoID = `photo`.PhotoID 
GROUP BY `name`
HAVING Total_Photo_Filesize > 1000;


-- THIS METHOD BELOW CALCULATES INDIVIDUAL FILE SIZE...
select name, filesize AS Total_Photo_Filesize
from `user`, `photo`, `user-photo`
where user.UserID IN
(
	  select album.UserID
	  from album
	  where PhotoID IN
	  (
			select photo.PhotoID
			from photo
			where filesize > 1000  
			));
                
-- 4.	List the names of albums (and the number of users owning the album) 
-- in which at least one photo belongs to more than 1 users.
SELECT AlbumName, count(*) AS total_users 
FROM album
GROUP BY AlbumName, PhotoID
HAVING total_users > 1;

-- 5. 	List the userid and user names of those who are following each other. 
-- For example, Ben Choi is following Jackie Tan and Jackie Tan is following Ben Choi. 
SELECT a.UserID AS userid, c.name as userName, a.FollowingUserID as following_userid, d.name as following_userName
FROM `user-following` as a, `user-following` as b,`user` as c, `user` as d
WHERE a.UserID = b.FollowingUserID
and a.UserID = c.UserID
and a.FollowingUserID = b.UserID
and a.FollowingUserID = d.UserID
ORDER BY a.UserID;

-- 6.	List the users who are involved in relational triads. 
-- For example, Ben Choi is following Jayden Johnson, 
-- Jayden Johnson is following Cammy Soh, Cammy Soh is following Ben Choi. 
SELECT g.`name` as User1, h.`name` as User2, i.`name` as User3
FROM `user-following` as d, `user-following` as e, `user-following` as f, `user` as g, `user` as h, `user` as i
WHERE d.UserID = e.FollowingUserID
and d.FollowingUserID = f.UserID
and f.FollowingUserID = e.UserID
and d.UserID = g.UserID
and d.FollowingUserID = h.UserID
and e.FollowingUserID = i.UserID
ORDER BY d.UserID;
