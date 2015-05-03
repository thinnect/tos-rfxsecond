/**
 * Directly make a second counter from a 62.5kHz counter.
 *
 * @author Raido Pahtma
 * @license MIT
*/
generic module SecondsFromT62khzP()
{
	provides interface Counter<TSecond, uint32_t> as Seconds;
	uses interface Counter<T62khz, uint32_t> as Counter;
}
implementation
{

	enum {
		COUNTER_FREQUENCY_HZ = 62500UL,
		COUNTER_WRAP_VALUE_S = 0xFFFFFFFF / COUNTER_FREQUENCY_HZ // max value of the underlying counter in seconds
	};

	uint32_t m_wraps = 0;

	async command uint32_t Seconds.get()
	{
		uint32_t v = 0;
		atomic
		{
			uint32_t wraps = m_wraps;
			uint32_t count = call Counter.get();
			if(call Counter.isOverflowPending()) // Think this might cause overflow signal and get reset?
			{
				wraps++;
				count = call Counter.get();
			}
			v = wraps * COUNTER_WRAP_VALUE_S + count / COUNTER_FREQUENCY_HZ;
		}
		return v;
	}

	async command bool Seconds.isOverflowPending()
	{
		return FALSE; // Counted from boot ... 136 years ... not worrying about that here
	}

  	async command void Seconds.clearOverflow() { }

	async event void Counter.overflow()
	{
		atomic
		{
			m_wraps++;
		}
	}
}

