Class {
	#name : 'LevenshteinSorterTest',
	#superclass : 'TestCase',
	#category : 'Levenshtein-Sorter-Tests',
	#package : 'Levenshtein-Sorter-Tests'
}

{ #category : 'tests' }
LevenshteinSorterTest >> testLevenshteinBasicExamples [
	| sorter |
	sorter := LevenshteinSorter new.

	self assert: (sorter levenshtein: 'kitten' with: 'sitting') equals: 3.
	self assert: (sorter levenshtein: 'flaw' with: 'lawn') equals: 2.
	self assert: (sorter levenshtein: 'gumbo' with: 'gambol') equals: 2.

]

{ #category : 'tests' }
LevenshteinSorterTest >> testLevenshteinEdgeCasesAndSymmetry [
	| sorter |
	sorter := LevenshteinSorter new.

	self assert: (sorter levenshtein: '' with: '') equals: 0.
	self assert: (sorter levenshtein: '' with: 'abc') equals: 3.
	self assert: (sorter levenshtein: 'abc' with: '') equals: 3.

	self assert:
		(sorter levenshtein: 'abc' with: 'yabd')
		equals:
		(sorter levenshtein: 'yabd' with: 'abc').

]
