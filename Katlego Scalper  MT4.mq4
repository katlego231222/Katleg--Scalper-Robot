 //+------------------------------------------------------------------+
 //| KATLEGO SCALPER ROBOT v1.0 - by Katlego231222                     |
 //+------------------------------------------------------------------+
 #property strict
 input double LotSize=0.01;
 input int StopLoss=100;
 input int TP1=150, TP2=300, TP3=500;
 input int EMA_Fast=9, EMA_Slow=21;
 input int Magic=77777;
 int OnInit(){return(INIT_SUCCEEDED);}
 void OnTick(){
  if(OrdersTotal()>0) return;
  double e9=iMA(NULL,0,EMA_Fast,0,MODE_EMA,PRICE_CLOSE,1);
  double e21=iMA(NULL,0,EMA_Slow,0,MODE_EMA,PRICE_CLOSE,1);
  double e9p=iMA(NULL,0,EMA_Fast,0,MODE_EMA,PRICE_CLOSE,2);
  double e21p=iMA(NULL,0,EMA_Slow,0,MODE_EMA,PRICE_CLOSE,2);
  double rsi=iRSI(NULL,0,14,PRICE_CLOSE,1);
  if(e9p<=e21p && e9>e21 && rsi>52){
   double sl=Ask-StopLoss*Point;
   double tp=Ask+TP1*Point;
   OrderSend(Symbol(),OP_BUY,LotSize,Ask,3,sl,tp,"KATLEGO BUY",Magic,0,Green);
  }
  if(e9p>=e21p && e9<e21 && rsi<48){
   double sl=Bid+StopLoss*Point;
   double tp=Bid-TP1*Point;
   OrderSend(Symbol(),OP_SELL,LotSize,Bid,3,sl,tp,"KATLEGO SELL",Magic,0,Red);
  }
 }
