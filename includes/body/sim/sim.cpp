$PROB
# One compartment model for drug A
- One-compartment PK model
- Dual first-order absorption
- Optional nonlinear clearance from `CENT`
- Source: `mrgsolve` internal library
- Date: `r Sys.Date()`
- Version: `r packageVersion("mrgsolve")`


$CMT @annotated
EV     : Extravascular compartment (mass, mg)
CENT   : Central compartment (mass, mg)
PERI   : Peripheral compartment (mass, mg/L)
AUC    : AUC

$GLOBAL
#define IPRED (CENT/V2)

$PARAM @annotated
TVVCL   	: 0.3040  : Individual Central Clearance (L/day)
TVVV2   	: 3.5900  : Individual Central Volume of Distribution (L)
TVVQ    	: 0.3190  : Individual Inter-compartmental Clearance (L/day)
TVVV3   	: 2.5300  : Individual Peripheral Volume of Distribution (L)
TVVKA   	: 0.1070  : Individual Absorption Constant (1/day)
TVVF1 	  : 0.5350  : Individual Bioavailability F in logit space (.)
BWE1      : 0.6180  : Body Weight Exponent on CL and Q
BWE2      : 0.5500  : Body Weight Exponent on V2 and V3
WT        : 0       : Individual Baeline Body Weight

$OMEGA @annotated @block
ECL : 0.0727 : Random effect on CL
EV2 : 0.0313 0.0390 : Random effect on V2
EF1 : 0.0417 0.0771 0.4790 : Random effect on F1

$SIGMA @annotated
PROP 	: 0.2010	: Proportional error
ADD	  : 0.0711  : Additive error

$MAIN
double TVCL = TVVCL*pow((WT/70),BWE1);
double TVV2 = TVVV2*pow((WT/70),BWE2);
double TVQ = TVVQ*pow((WT/70),BWE1);
double TVV3 = TVVV3*pow((WT/70),BWE2);
double TVKA = TVVKA;

double CL = TVCL*exp(ETA(1));
double V2 = TVV2*exp(ETA(2));
double Q = TVQ;
double V3 = TVV3;
double KA = TVKA;

double LF1 = log(TVVF1/(1-TVVF1)) + ETA(3);
double F1 = exp(LF1)/(1 + exp(LF1));

F_EV = F1;
EV_0 = 0;


$ODE
dxdt_EV = -KA*EV;
dxdt_CENT = KA*EV - CL/V2*CENT - Q/V2*CENT + Q/V3*PERI;
dxdt_PERI = Q/V2*CENT - Q/V3*PERI;
dxdt_AUC = CENT/V2;

$TABLE
capture double DV = (CENT/V2)*(1 + PROP) + ADD; //DV in ug/mL

$CAPTURE CL V2 Q V3 KA F1 IPRED DV
