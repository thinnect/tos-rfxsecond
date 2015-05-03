/**
 * Platform specific macros to transform seconds to milliseconds and back.
 *
 * @author Raido Pahtma
 * @license MIT
*/
#ifndef SEC_TMILLI
#warning "1 second == 976.5625 platform milliseconds"
#define SEC_TMILLI(seconds) ((seconds)*976.5625) // 62500Hz clock divided by 64
#define TMILLI_SEC(tmilli) ((tmilli)/976.5625)   // 62500Hz clock divided by 64
#endif // SEC_TMILLI