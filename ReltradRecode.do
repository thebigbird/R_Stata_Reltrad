*STATA code for RELTRAD (thanks to Brian Starks) 
* you need the data from the GSS website. Here's an example of what that looks like:
* use "/Users/thebigbird/Dropbox/Projects/SizeSatisfaction/datafiles/GSS2012merged_R4.dta", clear

* The following code breaks down religious groups by Protestant, Catholic,* 
* etc.* 
 
gen xaffil=relig 
recode xaffil 1=1 2=4 3=5 4=9 5/10=6 11=1 12=6 13=1 *=. 
label def xaffil 1 prot 4 cath 5 jew 6 other 9 nonaf 
label values xaffil xaffil 
 
* The following code breaks down religious groups by evangelicals, black* 
* Protestants, mainline, liberal and conservative nontraditional, * 
* and Protestant nondenomination/no denomination.* 
 
* Black Protestants* 
 
gen xbp=other 
recode xbp 7 14 15 21 37 38 56 78 79 85 86 87 88 98 103 104 128 133=1 *=0 
recode xbp 0=1 if denom==12 
recode xbp 0=1 if denom==13 
recode xbp 0=1 if denom==20 
recode xbp 0=1 if denom==21 
gen bl=race 
recode bl 2=1 *=0 
gen bldenom=denom*bl 
recode xbp 0=1 if bldenom==23 
recode xbp 0=1 if bldenom==28 
recode xbp 0=1 if bldenom==18 
recode xbp 0=1 if bldenom==15 
recode xbp 0=1 if bldenom==10 
recode xbp 0=1 if bldenom==11 
recode xbp 0=1 if bldenom==14 
gen blother=other*bl 
recode xbp 0=1 if blother==93 

*Evangelical Protestants* 
 
gen xev=other 
recode xev 2 3 5 6 9 10 12 13 16 18 20 22 24 26 27 28 31 32 34 35 36 39 41 42 43 45 47 ///
51 52 53 55 57 63 65 66 67 68 69 76 77 83 84 90 91 92 94 97 100 101 102 106 107 108 ///
109 110 111 112 115 116 117 118 120 121 122 124 125 127 129 131 132 134 135 138 ///
139 140 146=1 *=0 
recode xev 0=1 if denom==32 
recode xev 0=1 if denom==33 
recode xev 0=1 if denom==34 
recode xev 0=1 if denom==42 
gen wh=race 
recode wh 1=1 2=0 3=1 
gen whdenom=denom*wh 
recode xev 0=1 if whdenom==23 
recode xev 0=1 if whdenom==18 
recode xev 0=1 if whdenom==15 
recode xev 0=1 if whdenom==10 
recode xev 0=1 if whdenom==14 
gen whother=other*wh 
recode xev 0=1 if whother==93 
 
recode xev 1=0 if xbp==1 
 
* Mainline Protestants* 
 
gen xml=other 
recode xml 1 8 19 23 25 40 44 46 48 49 50 54 70 71 72 73 81 89 96 99 105 119 148=1 *=0 
recode xml 0=1 if denom==22 
recode xml 0=1 if denom==30 
recode xml 0=1 if denom==31 
recode xml 0=1 if denom==35 
recode xml 0=1 if denom==38 
recode xml 0=1 if denom==40 
recode xml 0=1 if denom==41 
recode xml 0=1 if denom==43 
recode xml 0=1 if denom==48 
recode xml 0=1 if denom==50 
recode xml 0=1 if whdenom==11 
recode xml 0=1 if whdenom==28 
 
* Catholics* 
 
gen xcath=other 
recode xcath 123=1 *=0 
recode xcath 0=1 if xaffil==4 
 
* Jews* 
 
gen xjew=0 
recode xjew 0=1 if xaffil==5 
 
* Adherents of other religions.* 
 
gen xother=other 
recode xother 11 17 29 30 33 58 59 60 61 62 64 74 75 80 82 95 113 114 130 136 141 ///
145=1 *=0 
gen noxev=1-xev 
gen noxevxaf=noxev*xaffil 
recode xother 0=1 if noxevxaf==6 
 
* Unaffiliateds/Nonaffiliateds.* 
 
gen xnonaff=xaffil 
recode xnonaff 9=1 *=0 
 
* NOTE: THE FOLLOWING DEALS WITH NO-DENOM AND * 
* NON-DENOM PROTESTANTS.* 
 
gen xprotdk=denom 
recode xprotdk 70=1 *=0 
recode xprotdk 1=0 if attend==0 
recode xprotdk 1=0 if attend==1 
recode xprotdk 1=0 if attend==2 
recode xprotdk 1=0 if attend==3 
recode xprotdk 1=0 if attend==9 
recode xprotdk 1=0 if attend==. 
recode xev 0=1 if xprotdk==1 
 
* Following does RELTRAD.* 
 
gen reltrad=0 
recode reltrad 0=7 if xnonaf==1 
recode reltrad 0=6 if xother==1 
recode reltrad 0=5 if xjew==1 
recode reltrad 0=4 if xcath==1 
recode reltrad 0=3 if xbp==1 
recode reltrad 0=2 if xml==1 
recode reltrad 0=1 if xev==1 
recode reltrad 0=. 
label def reltrad 1 "evangelical" 2 "mainline" 3 "black protestant" 4 "catholic" 5 "jewish" ///
6 "other faith" 7 "nonaffiliated" 
label values reltrad reltrad 


* This saves the file
* save "/Users/thebigbird/Dropbox/Projects/SizeSatisfaction/datafiles/GSS2012merged_R4.dta", replace
