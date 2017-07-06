

ALTER TABLE public."illumina sample locations" 
		
update public."illumina sample locations"
set geom = ST_Transform(ST_SetSRID(ST_MakePoint(longitude,latitude), 4326),32618)

alter table public."illumina sample locations"  set schema datadrwi

alter table datadrwi."illumina sample locations"  add column geom geometry (point, 32618)

UPDATE datadrwi."illumina sample locations"
SET geom = ST_Transform(ST_SetSRID(ST_MakePoint(longitude,latitude), 4326),32618)

SELECT * FROM datadrwi."illumina sample locations"

ALTER TABLE datadrwi."illumina sample locations"
SELECT geom 
FROM datadrwi."illumina sample locations" 
INTERSECT
SELECT catchment
FROM spatial.nhdplus;

SELECT a.nord, a.gnis_name,a.nordstop


INNER JOIN datadrwi."illumina sample locations" AS b


UPDATE datadrwi."illumina sample locations" AS a
SET nord = b.nord, nordstop = b.nordstop, waterway = b.gnis_name
FROM spatial.nhdplus AS b
WHERE St_Intersects(b.catchment,a.geom);

UPDATE datadrwi."illumina sample locations" AS a
SET localcatchsqkm = b.areasqkm, upstrmcatchsqkm = b.totdasqkm
FROM spatial.nhdplus AS b
WHERE St_Intersects(b.catchment,a.geom);

SELECT a.*,b.* FROM datadrwi."illumina sample locations"  AS a RIGHT JOIN spatial.nhdplus as b
ON a.nord = b.nord

ALTER TABLE datadrwi."illumina sample locations"  ADD COLUMN localcatchsqkm numeric(16,2);
ALTER TABLE datadrwi."illumina sample locations"  ADD COLUMN upstrmcatchsqkm numeric(16,2);
