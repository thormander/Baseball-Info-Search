--
-- Information dump for 'analysis.sql'
--
REPLACE INTO analysis(playerid,yearid,birthyear,teamid,lgid,g,ab,r,h,b2,b3,hr,rbi,sb,
cs,bb,so,ibb,hbp,sh,sf,gidp) 
SELECT b.playerid,yearid,birthyear,teamid,lgid,SUM(g),SUM(ab),SUM(r),SUM(h),SUM(2b),
SUM(3b),SUM(hr),SUM(rbi),SUM(sb), SUM(cs),SUM( bb),SUM(so),
SUM(ibb),SUM(hbp),SUM(sh),SUM(sf),SUM(gidp) 
FROM people p JOIN batting b USING(playerid) GROUP BY b.playerid,yearid,teamid,lgid,birthyear;

UPDATE analysis SET bpf = (SELECT bpf FROM teams WHERE teams.teamid=analysis.teamid AND teams.yearid=analysis.yearid GROUP BY bpf,teamid,yearid);

UPDATE analysis a SET tb = h+b2+2*b3+3*hr, obp = 
        CASE 
                WHEN ab+bb+COALESCE(hbp,0)+COALESCE(sf,0) = 0 THEN 0 
                ELSE (SELECT (h+bb+COALESCE(hbp,0)) / (ab+bb+COALESCE(hbp,0)+COALESCE(sf,0)) 
			FROM analysis b 
			WHERE a.playerid = b.playerid AND a.yearid = b.yearid) 
        END;

#UPDATE analysis SET tb=h+b2+2*b3+3*hr;  already in above update
UPDATE analysis SET rc=obp*tb; 
UPDATE analysis SET age=yearid-birthyear;
UPDATE analysis SET pa=ab+bb+COALESCE(hbp,0)+COALESCE(sh,0)+COALESCE(sf,0);
UPDATE analysis SET slg=tb/ab;
UPDATE analysis SET parc= rc /((bpf+100)/200);
UPDATE analysis SET parcper27= (27*parc)/(ab-h+COALESCE(sf,0)+COALESCE(sh,0)+COALESCE(cs,0)+COALESCE(gidp,0));
UPDATE analysis SET ops= obp+slg;
UPDATE analysis SET rc27= (27*rc)/(ab-h+COALESCE(sf,0)+COALESCE(sh,0)+COALESCE(cs,0)+COALESCE(gidp,0));  #added in because some players would  cause server to crash mostly if they have a bunch of 0's for their data

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#if python doesn't work for parcper27 use below update
#UPDATE analysis SET parcper27= (27*parc)/(ab-h+COALESCE(sf,0)+COALESCE(sh,0)+COALESCE(cs,0)+COALESCE(gidp,0));

#individual queries below
#age
#SELECT TIMESTAMPDIFF(YEAR,birthYear,yearid) FROM people p WHERE p.playerid = #b.playerid


#--------------------------------------------------SCRATCH below
#REPLACE INTO analysis(playerid,yearid,birthyear,teamid,lgid,g,ab,r,h,b2,b3,hr,rbi,sb,
#cs,bb,so,ibb,hbp,sh,sf,gidp,bpf) 
#SELECT b.playerid,b.yearid,COALESCE(birthyear,0),b.teamid,b.lgid,SUM(b.g),SUM(b.ab),SUM(b.r),SUM(b.h),SUM(b.2b),
#SUM(b.3b),SUM(b.hr),SUM(b.rbi),SUM(b.sb), SUM(b.cs),SUM(b.bb),SUM(b.so),
#SUM(b.ibb),SUM(b.hbp),SUM(b.sh),SUM(b.sf),SUM(b.gidp),COALESCE(bpf,0) 
#FROM people p JOIN batting b USING(playerid) JOIN teams t USING(teamid) GROUP BY b.playerid,b.yearid,b.teamid,b.lgid;

#REPLACE INTO analysis(birthYear) SELECT SUM(birthYear) FROM people p JOIN batting b USING(playerid) GROUP BY b.playerid,yearid-
#SELECT b.lgid,b.yearid,b.teamid,b.playerid, COALESCE(birthyear,0),COALESCE(bpf,0) FROM teams t JOIN batting b USING(teamid) JOIN people p USING(playerid) GROUP BY b.playerid, b.lgid, b.teamid,b.yearid ORDER BY b.yearid LIMIT 20;

#INSERT INTO analysis(playerid,yearid,birthyear,teamid,lgid,g,ab,r,h,b2,b3,hr,rbi,sb,
#cs,bb,so,ibb,hbp,sh,sf,gidp) 
#SELECT b.playerid,yearid,SUM(birthyear),teamid,lgid,SUM(g),SUM(ab),SUM(r),SUM(h),SUM(2b),
#SUM(3b),SUM(hr),SUM(rbi),SUM(sb), SUM(cs),SUM( bb),SUM(so),
#SUM(ibb),SUM(hbp),SUM(sh),SUM(sf),SUM(gidp) 
#FROM people p JOIN batting b USING(playerid) GROUP BY b.playerid,yearid,teamid,lgid;
