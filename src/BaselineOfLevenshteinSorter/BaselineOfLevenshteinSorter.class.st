Class {
	#name : 'BaselineOfLevenshteinSorter',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfLevenshteinSorter',
	#package : 'BaselineOfLevenshteinSorter'
}

{ #category : 'baselines' }
BaselineOfLevenshteinSorter >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec package: 'Levenshtein-Sorter'.
			spec package: 'Levenshtein-Sorter-Tests' with: [ spec requires: #( 'Levenshtein-Sorter' ) ]].
]
