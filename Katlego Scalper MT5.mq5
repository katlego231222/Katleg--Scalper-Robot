//+------------------------------------------------------------------+
//| KATLEGO SCALPER ROBOT v1.0 MT5 - by Katlego231222                |
//| M5 Scalper with TP1 TP2 TP3                                      |
//+------------------------------------------------------------------+
#property strict

input double LotSize=0.01;
input int StopLoss=100;
input int TP1=150;
input int TP2=300;
input int TP3=500;
input int EMA_Fast=9;
input int EMA_Slow=21;
input int MagicNumber=77777;

int emaHandleFast, emaHandleSlow, rsiHandle;

int OnInit()
{
   emaHandleFast = iMA(_Symbol, PERIOD_M5, EMA_Fast, 0, MODE_EMA, PRICE_CLOSE);
   emaHandleSlow = iMA(_Symbol, PERIOD_M5, EMA_Slow, 0, MODE_EMA, PRICE_CLOSE);
   rsiHandle = iRSI(_Symbol, PERIOD_M5, 14, PRICE_CLOSE);
   return(INIT_SUCCEEDED);
}

void OnTick()
{
   if(PositionSelect(_Symbol)) return;

   double emaFast[3], emaSlow[3], rsi[2];
   CopyBuffer(emaHandleFast,0,1,2,emaFast);
   CopyBuffer(emaHandleSlow,0,1,2,emaSlow);
   CopyBuffer(rsiHandle,0,1,1,rsi);

   double price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   
   // BUY SIGNAL: EMA Cross Up + RSI > 52
   if(emaFast[1] > emaSlow[1] && rsi[0] > 52)
   {
      double sl = price - StopLoss * _Point * 10;
      double tp = price + TP1 * _Point * 10;
      trade.Buy(LotSize, _Symbol, price, sl, tp, "KATLEGO BUY");
   }
   
   // SELL SIGNAL: EMA Cross Down + RSI < 48
   if(emaFast[1] < emaSlow[1] && rsi[0] < 48)
   {
      double sl = price + StopLoss * _Point * 10;
      double tp = price - TP1 * _Point * 10;
      trade.Sell(LotSize, _Symbol, price, sl, tp, "KATLEGO SELL");
   }
}
#include <Trade\Trade.mqh>
CTrade trade;
