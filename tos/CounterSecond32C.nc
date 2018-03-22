/**
 * Directly make a second counter from a 62.5kHz counter.
 *
 * @author Raido Pahtma
 * @license MIT
*/
#include "sec_tmilli.h"
configuration CounterSecond32C {
	provides interface Counter<TSecond, uint32_t>;
}
implementation {

	#warning "T62khz Second counter, 1 second == 976.5625 platform milliseconds"

	// components new SecondsFromT62khzP();
	// Counter = SecondsFromT62khzP.Seconds;

	// components Counter62khz32C;
	// SecondsFromT62khzP.Counter -> Counter62khz32C;

	components AlarmCounterMilliP as CounterFrom;

  	components new TransformCounterC(TSecond,uint32_t,TMilli,uint32_t,10,uint32_t) as Transform;

  	Counter = Transform.Counter;

  	Transform.CounterFrom -> CounterFrom;


}