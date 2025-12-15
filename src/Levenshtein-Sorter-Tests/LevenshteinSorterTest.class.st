Class {
	#name : 'LevenshteinSorterTest',
	#superclass : 'TestCase',
	#category : 'Levenshtein-Sorter-Tests',
	#package : 'Levenshtein-Sorter-Tests'
}

{ #category : 'tests' }
LevenshteinSorterTest >> testSortsAlphabeticallyWhenDistancesAreEqual [

    | sorter context result |
    sorter := LevenshteinSorter new.
    context := LevenshteinSorterTestContext new
        currentWord: 'a';
        yourself.
    sorter context: context.

    result := sorter sortCompletionList: #( 'ab' 'aa' 'ac' ).

    self assert: result asArray equals: #('aa' 'ab' 'ac')
]

{ #category : 'tests' }
LevenshteinSorterTest >> testSortsByLevenshteinDistance [

    | sorter context result |
    sorter := LevenshteinSorter new.
    context := LevenshteinSorterTestContext new
        currentWord: 'hel';
        yourself.
    sorter context: context.

    result := sorter sortCompletionList: #( 'hello' 'help' 'world' ).

    self assert: result asArray equals: #('help' 'hello' 'world')
]
