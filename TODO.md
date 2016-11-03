# CESM model runs
- EC2 instance automatic startup/teardown
	- case string set descriptively
	- run database, searchable by all relevant variables
		- API for retrieving data by run ID, variable name, time (API Gateway + Lambda)
	- output data processed on each st_archive call
		- variables extracted into time series
		- variables saved to s3://cesm-output-data
		- registered in run DB
- run query script
	- query by variable value
	- tabulated output
		- last update
		- instance, performance summary
- API gateway to serve output files via HTTP
- NetCDF to movie script (Pillow, ImageMagick, OpenCV, ffmpeg)
- NetCDF metadata python parser
- long-term RCP runs complete and checked for consistency
- figure out how to make my own forcing inputs - look at forcing compsets and spot differences in input data and config vars
- multi-machine
- image downloaded from repo rather than built
- continue run from previous 

- map surface land use data to geodesic grid
- data structure and store for grid cell info
	- physical: elevation, soil composition, vegetation, albedo
	- land use
	- economic activity
	- population
	- emissions
	- labels: city names

# Output visualization
- Land use - hexagonal grid
- Photorealistic surface & clouds - overwatch view
- Ocean volumetrics
- Atmosphere volumetrics