/*********************************************
* OPL 12.9.0.0 Model
? * Author: Acer
? * Creation Date: May 28, 2019 at 1:24:04 PM
 *********************************************/
using CP;
//Data definition
int iv=...;//initial value
int nbexam=...;//Number of instances
range iteration=1..nbexam;
int Njob=...;
int Nmach=...;

tuple group//
{
int p[1..Njob];//the processing time of each job
int w[1..Njob];//the weight of each job
int s[1..Njob];//the size of each job
}
group job[iteration]=...;

 //决策变量
dvar int X[1..Njob][1..Njob][1..Nmach] in 0..1;
int S[1..Nmach]=[10,10,25];
dvar int cp[1..Njob];
dvar int C[0..Njob][1..Nmach];
dvar int P[1..Njob][1..Nmach];

dvar int WC;
 
//objective function
minimize  WC; 

//restrictions
constraint ct1;
constraint ct2;
constraint ct3;
constraint ct4;
constraint ct5;
constraint ct6;
constraint ct7;

subject to
{
ct1=
forall(j in 1..Njob)
  	sum(b in 1..Njob,i in 1..Nmach)X[j][b][i]==1; 
ct2=
forall(b in 1..Njob,i in 1..Nmach)
  	sum(j in 1..Njob)(job[iv].s[j]*X[j][b][i])<=S[i];//Capacity limit
  
ct3=
forall(j in 1..Njob,b in 1..Njob,i in 1..Nmach)
  	  P[b][i]>=job[iv].p[j]*X[j][b][i];//Processing time

ct4=
forall(i in 1..Nmach)
	C[0][i]==0;
	
ct5=
forall(b in 1..Njob,i in 1..Nmach)
    C[b][i]>=C[b-1][i]+P[b][i];//Completion Time
   
ct6=
forall(j in 1..Njob)	
  	cp[j]==sum(b in 1..Njob,i in 1..Nmach)(X[j][b][i]*C[b][i]);//Completion Time of job
  	
ct7=
	WC==sum(j in 1..Njob)(job[iv].w[j]*cp[j]);//TWC
  		
}
  
execute {
writeln(WC);
}