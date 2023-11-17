contract;

storage {
    counter: u64 = 0,
}

abi Counter {
    #[storage(read, write)]
    fn increment();
 
    #[storage(read)]
    fn count() -> u64;
}

impl Counter for Contract {
    #[storage(read)]
    fn count() -> u64 {
        storage.counter.read()
    }
 
    #[storage(read, write)]
    fn increment() {
        let incremented = storage.counter.read() + 1;
        require((incremented > storage.counter.read()), "error during increment: new value is lower than old one!");
        storage.counter.write(incremented);
    }


}
    #[test()]
    fn test_success() {
        let my_abi = abi(Counter, CONTRACT_ID);
        let old_value = my_abi.count();
        my_abi.increment();
    	let result = my_abi.count();
	    assert(result == (old_value + 1))
    }