address lesson1{
    /*
    module HelloWorld{
        use std::debug::print;
        use std::string::String;
        use std::string::utf8;
        use std::vector;

        const ARR: vector<u64> = vector[1,2,3,4,5,6,7,8,9,10];

        struct Wallet has drop {
            balance: u64,
        }

        #[test]
        fun test_hello_world() {
            print(&utf8(b"Hello World")); // & var readonly; $mut var read and write
        }
        #[test]
        fun test_wallet() {
            let wallet = Wallet { balance: 1000 };
            let wallet2 = wallet;
            //print(&wallet.balance);
            print(&wallet2.balance);
        }
        #[test]
        fun test_num() {
            let num_u8: u8 = 42;
            let num_u64 = 1024u64;
            let num_u8_2: u8 = 0x2A;
            let num_u256: u256 = 100_000;
            let num_sum: u256 = (num_u8 as u256) + num_u256;

            print(&num_u8);
            print(&num_u64);
            print(&num_u8_2);
            print(&num_u256);
            print(&num_sum);
        }
        #[test]
        fun test_bool() {
            let bool_true: bool = true;
            let bool_false: bool = false;

            print(&bool_true);
            print(&bool_false);
            print(&(bool_true == bool_false));
        }
        #[test]
        fun test_string() {
            let str: String = utf8(b"hello world");

            print(&str);
        }
        #[test]
        fun test_addr() {
            let addr: address = @0x2A;
            print(&addr);
        }
        #[test]
        fun test_vector() {
            print(&ARR);

            let is_empty: bool = vector::is_empty(&ARR);
            print(&is_empty);

            let length: u64 = vector::length(&ARR);
            print(&length);

            let val = vector::borrow(&ARR, 3);
            print(val);

            let arr: vector<u64> = vector[1,2,3,4,5];
            let val2 = vector::borrow_mut(&mut arr, 3);
            *val2 = 100;
            print(&arr);

            let has_3: bool = vector::contains(&ARR, &3);
            print(&has_3);

            let (isIndex, index) = vector::index_of(&ARR, &3);
            print(&isIndex);
            print(&index);

            let arr2 = vector[2,2,2];
            vector::push_back(&mut arr2, 2);
            print(&arr2);

            let arr3 = vector[3,3,3];
            vector::append(&mut arr3, arr2);
            print(&arr3);

            let arr4 = vector[4,4,4];
            let arr5 = vector[4,5,6];
            vector::reverse_append(&mut arr4, arr5);
            print(&arr4);

            let arr6 = vector[1,2,3];
            let x = vector::pop_back(&mut arr6);
            print(&arr6);
            print(&x);

            let arr7 = vector[1,2,3,4];
            let len = vector::length(&arr7);
            vector::swap(&mut arr7, 0, len - 1);
            print(&arr7);

            let arr8 = vector[1,2,3,4];
            vector::reverse(&mut arr8);
            print(&arr8);

            let arr9 = vector[1,2];
            vector::insert(&mut arr9, 1, 3);
            print(&arr9);

            let arr10 = vector[1,2,3];
            vector::remove(&mut arr10, 1);
            print(&arr10);

            let arr16 = vector[1,2,3,4,5];
            vector::swap_remove(&mut arr16, 2);
            print(&arr16);

            let arr11 = vector[1,2,3];
            let arr12 = vector::trim(&mut arr11, 1);
            print(&arr11);
            print(&arr12);

            let arr13 = vector[1,2,3,4,5];
            let arr14 = vector::trim_reverse(&mut arr13, 3);
            print(&arr13);
            print(&arr14);

            let arr15 = vector[1,2,3,4,5];
            vector::rotate(&mut arr15, 2);
            print(&arr15);

        }
    }

    // no public, friend public, public
    module m {
        friend lesson1::m3;
        fun f1(): u64 {
            return 1
        }

        public fun f2(): u64 {
            return 2
        }

        public(friend) fun f3(): u64 {
            return 3
        }
    }

    module m2 {
        fun f1(): u64 {
            return lesson1::m::f2()
        }
    }

    module m3 {
        fun f1(): u64 {
            return lesson1::m::f3()
        }
    }

     // acquires fun call move_from,move_to, borrow_global, borrow_global_mut
    module m4 {
        use std::debug::print;
        use std::signer;

        struct Coin has key {
            value: u64
        }

        public entry fun mint (account: &signer, value: u64) {
            move_to(account, Coin{value});
        }

        #[test(account= @0x42)]
        public fun test_mint(account: &signer) acquires Coin {
            let addr = signer::address_of(account);
            mint(account, 100);
            let value = borrow_global<Coin>(addr).value;
            print(&value);
        }

    }

    // copy drop key store
    module mStruct {
        use std::debug::print;
        use std::signer;

        struct Foo has drop {
            u: u64,
            b: bool
        }

        #[test]
        fun test_foo() {
            let f = Foo{u: 42, b: true};
            print(&f);

            let Foo{u, b} = &mut f;
            *u = 43;
            *b = false;
            print(&f);
        }

        struct CanCopy has copy, drop{
            x: u64,
            y: u64
        }

        #[test]
        fun test_copy() {
            let obj = CanCopy{x: 40, y: 50};
            let objCopy = copy obj;
            let CanCopy{x,y} = &mut objCopy;
            *x = 10;
            *y = 20;
            print(&objCopy);
            print(&obj);
        }

        struct Key has key, drop {
            s: Str
        }
        struct Str has store, drop {
            x: u64
        }

        #[test]
        fun test_store_key() {
            let s = Str{ x: 9999 };
            let k = Key{ s };

            print(&k.s.x);
        }
    }
    // if while and loop
    module mIWL {
        use std::debug::print;

        #[test]
        fun test_if() {
            let x = 10;
            if(x == 5) {
                print(&x);
            } else {
                print(&10);
            }
        }

        #[test]
        fun test_while() {
            let x = 10;
            while( x > 0 ) {
                x = x - 1;
                if(x == 5)
                    continue;
                if(x==3)
                    break;
                print(&x);
            }
        }

        #[test]
        fun test_loop() {
            let x = 10;
            loop {
                x = x - 1;
                if(x == 5) 
                    continue;

                if(x == 0)
                    break;
                print(&x);
            }
        }
    }
    */
    module mModule {
        use std::debug::{print as P, native_print, print};

        // use std::debug::{print as P, native_print, print};
        #[test]
        fun test_alice() {
            let v = 10;
            print(&v);
            P(&v);
        }
    }
}