@isTest
private class Hell1Test {
    static Hell1 obj = new Hell1();
    
    @isTest
    private static void testReverseString(){
		System.assertEquals( 'anhsirk', obj.reverseString('krishna'));
        System.assertEquals( 'civic', obj.reverseString('civic') );
        System.assertEquals( 'fds32', obj.reverseString('23sdf') );
        
    }
    
    @isTest
    private static void testPalindromeString(){
        System.assertEquals( true, obj.checkPalindrome('civic') );
        System.assertEquals( false, obj.checkPalindrome('hell') );
        System.assertEquals( false, obj.checkPalindrome('krishna') );
    }
    
    @isTest
    private static void testCountVowels(){
        
        System.assertEquals( 5, obj.countVowels('aeiou') );
        System.assertEquals(1, obj.countVowels('lllli'));
    }
    
    @isTest
    private static void testIsPrime(){
        System.assertEquals(true, obj.isPrime(2), '2 should be prime');
        System.assertEquals(true, obj.isPrime(3), '3 should be prime');
        System.assertEquals(false, obj.isPrime(4), '4 is not a prime');
    }
    
    @isTest
    private static void testFizzBuzz(){
        obj.fizzBuzz();
    }
    
    @isTest
    private static void testGetFactorial() {
        System.assertEquals(1, obj.getFactorial(0), 'Factorial of 0 should be 1');
        System.assertEquals(1, obj.getFactorial(1), 'Factorial of 1 should be 1');
        System.assertEquals(2, obj.getFactorial(2), 'Factorial of 2 should be 2');
        System.assertEquals(6, obj.getFactorial(3), 'Factorial of 3 should be 6');
        System.assertEquals(24, obj.getFactorial(4), 'Factorial of 4 should be 24');
        System.assertEquals(120, obj.getFactorial(5), 'Factorial of 5 should be 120');
        System.assertEquals(3628800, obj.getFactorial(10), 'Factorial of 10 should be 3628800');
    }

    @isTest
    private static void testPrintFibonacci() {
    
        obj.printFibonacci(1); 
        obj.printFibonacci(5); 
        obj.printFibonacci(10); 
    
    }

    @isTest
    private static void testPrintEvenOddCount(){
        obj.printEvenOddCount( new List<Integer>{1,2,3,4,56,6,5,74,7,8,9} );
    }
    
    @isTest
    private static void testGetDigitsCount(){
        System.assertEquals(10, obj.getDigitsCount(1234));
        System.assertEquals(6, obj.getDigitsCount(123));
        System.assertEquals(15, obj.getDigitsCount(12354));
        System.assertEquals(5, obj.getDigitsCount(14));
    }
    
    @isTest
    private static void testIsArmstrong(){
        System.assertEquals(false, obj.isArmstrong(1234));
        System.assertEquals(false, obj.isArmstrong(12));
        System.assertEquals(true, obj.isArmstrong(153));
        System.assertEquals(true, obj.isArmstrong(1634));
    }
    
    @isTest
    private static void testGetUniqueElements() {
        // Test case 1: Normal case with duplicates
        List<Integer> input1 = new List<Integer>{1, 2, 3, 2, 4, 3};
        List<Integer> expected1 = new List<Integer>{1, 4};
        System.assertEquals(expected1, obj.getUniqueElements(input1));

        // Test case 2: All unique
        List<Integer> input2 = new List<Integer>{5, 6, 7};
        List<Integer> expected2 = new List<Integer>{5, 6, 7};
        System.assertEquals(expected2, obj.getUniqueElements(input2));

        // Test case 3: All duplicates
        List<Integer> input3 = new List<Integer>{8, 8, 9, 9};
        List<Integer> expected3 = new List<Integer>{};
        System.assertEquals(expected3, obj.getUniqueElements(input3));

        // Test case 4: Empty list
        List<Integer> input4 = new List<Integer>{};
        List<Integer> expected4 = new List<Integer>{};
        System.assertEquals(expected4, obj.getUniqueElements(input4));

        // Test case 5: One element
        List<Integer> input5 = new List<Integer>{42};
        List<Integer> expected5 = new List<Integer>{42};
        System.assertEquals(expected5, obj.getUniqueElements(input5));
    }
    
     @isTest
    private static void testSortingMethods() {
        // Ascending Sort 
        System.assertEquals(new List<Integer>{1, 3, 4, 5, 9}, obj.sortToAscending(new List<Integer>{9, 3, 5, 1, 4}));
        System.assertEquals(new List<Integer>{1, 2, 3, 4}, obj.sortToAscending(new List<Integer>{1, 2, 3, 4}));
        System.assertEquals(new List<Integer>{1, 2, 3, 4, 5}, obj.sortToAscending(new List<Integer>{5, 4, 3, 2, 1}));
        System.assertEquals(new List<Integer>{2, 2, 3, 4, 4}, obj.sortToAscending(new List<Integer>{4, 2, 4, 3, 2}));
        System.assertEquals(new List<Integer>{100}, obj.sortToAscending(new List<Integer>{100}));
        System.assertEquals(new List<Integer>{}, obj.sortToAscending(new List<Integer>{}));

        // Descending Sort 
        List<Integer> d1 = new List<Integer>{3, 9, 1, 5, 4};
        obj.sortToDescending(d1);
        System.assertEquals(new List<Integer>{9, 5, 4, 3, 1}, d1);

        List<Integer> d2 = new List<Integer>{10, 8, 6, 4};
        obj.sortToDescending(d2);
        System.assertEquals(new List<Integer>{10, 8, 6, 4}, d2);

        List<Integer> d3 = new List<Integer>{1, 2, 3, 4, 5};
        obj.sortToDescending(d3);
        System.assertEquals(new List<Integer>{5, 4, 3, 2, 1}, d3);

        List<Integer> d4 = new List<Integer>{4, 2, 4, 3, 2};
        obj.sortToDescending(d4);
        System.assertEquals(new List<Integer>{4, 4, 3, 2, 2}, d4);

        List<Integer> d5 = new List<Integer>{55};
        obj.sortToDescending(d5);
        System.assertEquals(new List<Integer>{55}, d5);

        List<Integer> d6 = new List<Integer>{};
        obj.sortToDescending(d6);
        System.assertEquals(new List<Integer>{}, d6);
    }
    
    @isTest
    private static void testPrintLargestAndSmallest() {
        obj.printLargestAndSmallest(new List<Integer>{5, 3, 9, 1, 7});
        obj.printLargestAndSmallest(new List<Integer>{100});
        obj.printLargestAndSmallest(new List<Integer>{-3, -7, 0, -1});
        obj.printLargestAndSmallest(new List<Integer>{9, 9, 9});
        obj.printLargestAndSmallest(new List<Integer>{1, 2});
    }
    
    @isTest
    private static void testGetCommonElements() {
        System.assertEquals(new List<Integer>{3, 4}, obj.getCommonElemetns(
            new List<Integer>{1, 2, 3, 4}, new List<Integer>{3, 4, 5}));
    
        System.assertEquals(new List<Integer>{1, 2, 3}, obj.getCommonElemetns(
            new List<Integer>{1, 2, 3}, new List<Integer>{3, 2, 1}));
    
        System.assertEquals(new List<Integer>{}, obj.getCommonElemetns(
            new List<Integer>{7, 8}, new List<Integer>{1, 2}));
    
        System.assertEquals(new List<Integer>{2, 3}, obj.getCommonElemetns(
            new List<Integer>{1, 2, 2, 3}, new List<Integer>{2, 3, 3}));
    
        System.assertEquals(new List<Integer>{}, obj.getCommonElemetns(
            new List<Integer>{}, new List<Integer>{}));
    
        System.assertEquals(new List<Integer>{}, obj.getCommonElemetns(
            new List<Integer>{1, 2}, new List<Integer>{}));
    }

    @isTest
    private static void testPrintSecondLargest(){
        obj.printSecondLargestNumber(new List<Integer>{5, 3, 9, 1, 7});
        obj.printSecondLargestNumber(new List<Integer>{-3, -7, 0, -1});
        obj.printSecondLargestNumber(new List<Integer>{9, 9, 9});
    }
    
    @isTest
    private static void testPatternOne(){
		obj.patternOne(6);
        obj.patternTwo(7);
        obj.printAlphabetCount('Hey there, This side Krishna soni');
    }
    
    @isTest
    private static void testGetSortedMergedList() {
        
    
        System.assertEquals(
            new List<Integer>{1, 2, 3, 4, 5, 6},
            obj.getSortedMergedList(
                new List<Integer>{3, 1, 5},
                new List<Integer>{4, 2, 6}
            )
        );
    
        System.assertEquals(
            new List<Integer>{1, 2, 2, 3},
            obj.getSortedMergedList(
                new List<Integer>{1, 2},
                new List<Integer>{2, 3}
            )
        );
    
        System.assertEquals(
            new List<Integer>{},
            obj.getSortedMergedList(
                new List<Integer>{},
                new List<Integer>{}
            )
        );
    
        System.assertEquals(
            new List<Integer>{5, 7, 9},
            obj.getSortedMergedList(
                new List<Integer>{5},
                new List<Integer>{9, 7}
            )
        );
    }

    
}