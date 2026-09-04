# black-capped-vireo-song-data
Title: 

Song characteristics indicate resource holding potential in the black-capped vireo (Vireo atricapilla)

Description: 

Here we investigate song characteristics of the black-capped vireo, a vulnerable songbird. We first provide a general description of the song traits of male black-capped vireos, such as repertoire size, song length, and repeatability. We then investigate the influence of morphometric traits on song traits, as well as the relationship between song traits and resource holding potential in this species. We find a possible trade-off between bandwidth and repertoire size within our focal population. We also find that multiple song traits may act as indicators of resource holding potential in male black-capped vireos, and further that song may be shaped by this species’ habitat structure.

Files and variables:


File: GIS_Song.csv

Description: song variables and GIS territory variables

Variables:

ID: individual bird identification

num_songtyp: total number of song types per individual

uni_notetyp: total number of unique note types per individual

avg_songlength: average song length (seconds)

avg_songbw: average song bandwidth (Hz)

avg_min: average PFC minimum measurement

avg_max: average PFC maximum measurement

avg_note_bw: average note bandwidth (Hz)

terr_size: territory size (m^2)

max_height: maximum vegetation height within territory

avg_height: average vegetation height within territory

ground: percentage of territory categorized as 'ground' (0-0.1 m)

low: percentage of territory categorized as 'low vegetation' (0.1-1 m)

med: percentage of territory categorized as 'medium vegetation'' (1-2 m)

high: percentage of territory categorized as 'high vegetation' (2-3 m)

very_high: percentage of territory categorized as 'very high vegetation' (3+ m)


File: Morphometrics_Song.csv

Description: song variables and morphometric variables

Variables:

id: individual bird identification

num_songtyp: total number of song types per individual

uni_notetyp: total number of unique note types per individual

avg_songlength: average song length (seconds)

avg_minfreq: average PFC minimum measurement

avg_songbw: average song bandwidth (Hz)

avg_max: average PFC maximum measurement

avg_note_bw: average note bandwidth (Hz)

muscle: muscle score (0-3)

fat: fat score (0-3)

wing: wing length measurement (mm)

tail: tail length measurement (mm)

tarsus: tarsus length measurement (mm)

mass: mass measurement (g)

beak_l: beak length measurement (mm)

beak_w: beak width measurement (mm)

beak_d: beak depth measurement (mm)

tip_nares: beak tip to nares measurement (mm)

scaledmass: scaled mass index


File: Repeatability.csv

Description: song variables used to calculate repeatability scores

Variables:

male_ID: individual bird identification

num_notes: number of notes per song

num_notetype: number of note types per individual

song_length: average song length (seconds)

pfcmax: average PFC maximum measurement

pfcmin: average PFC minimum measurement

bandwidth: average song bandwidth


File: Song_Stats.csv

Description: all statistics for song variables calculated from the original raw measurements

Variables: 

ID: individual bird identification

num_song_types: number of song types per individual

avg_num_notes_per_song: average number of notes per song

num_unique_note_types: number of unique note types per individual

avg_num_note_types_per_song: average number of note types per song

avg_song_length: average song length (seconds)

avg_pfc_max: average PFC maximum

avg_pcf_min: average PFC minimum

avg_song_bandwidth: average song bandwidth (Hz)

avg_note_bandwidth: average note bandwidth (Hz)

File: Raw_Raven_Song_Measurements.csv

Description: 

Variables

File Name: file name

# Song Type: unique song type (a-z)

# Notes: number of notes in song

# Unique Note Types: number of total unique note types per individual

# Note Types: number of note types per song

Song Length: song length (seconds)

PFC Max Freq (Hz): song PFC maximum frequency (Hz) (first occurrence only)

PFC Min Freq (Hz): song PFC minimum frequency (Hz) (first occurrence only)

Bandwidth: song bandwidth (first occurrence only)

Note Length (s): note length (s)

PFC Max Freq (Hz): note PFC maximum frequency (Hz) (all other occurrences)

PFC Min Freq (Hz): note PFC minimum frequency (Hz) (all other occurrence)

Bandwidth: note bandwidth (all other occurrences)


File: Territory_Song.csv

Description: song variables and hand measured territory variables

Variables:

ID: individual bird ID

avgcanopy_tenm: average canopy cover (0-96) within 10m radius of point

avgvegh_tenm: average vegetation height (m) within 10m radius of point

shrub_percent: percentage of ground cover consisting of shrubs within 10m radius of point

tree_percent: percentage of ground cover consisting of trees within 10m radius of point

number_trees: number of shrubs within 10m radius of point

number_shrubs: number of trees within 10m radius of point

num_songtyp: number of song types per individual

uni_notetyp: number of unique note types per individual

avg_songlength: average song length (seconds)

avg_songbw: average song bandwidth

avg_note_bw: average note bandwidth

avg_min: average PFC minimum (Hz)

avg_max: average PFC maximum (Hz)


File: Code.R

Description: all code used to generate all results for this paper, including annotations.

Code/software: 

R 4.4.1 and RStudio 2023.12.0 were used to obtain all results.

Packages used:

-ggplot 3.5.1

-MuMln 1.48.4

-effects 4.2-2

-performance 0.12.3

-car 3.1-2

-rptr 0.9.23

-readr 2.1.5

All .csv files were created using Excel Version 2608 Build 16.0.20326.20072.
