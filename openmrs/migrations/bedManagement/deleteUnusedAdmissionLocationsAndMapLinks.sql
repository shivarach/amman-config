SELECT location_tag_id INTO @general_ward_tag_id FROM location_tag WHERE name = 'Admission Location' AND description = 'General ward (4th floor)' AND retired = FALSE ;
SELECT location_tag_id INTO @ward_tag_id FROM location_tag WHERE name = 'Admission Location' AND description = 'Hospital Wards' AND retired = FALSE ;
SELECT location_tag_id INTO @kahramana_tag_id FROM location_tag WHERE name = 'Admission Location' AND description = 'Kahramana Hotel' AND retired = FALSE ;
SELECT location_tag_id INTO @rc_tag_id FROM location_tag WHERE name = 'Admission Location' AND description = 'Rehabilitation center' AND retired = FALSE ;

DELETE FROM location_tag_map WHERE location_tag_id = @general_ward_tag_id;
DELETE FROM location_tag_map WHERE location_tag_id = @ward_tag_id;
DELETE FROM location_tag_map WHERE location_tag_id = @kahramana_tag_id;
DELETE FROM location_tag_map WHERE location_tag_id = @rc_tag_id;

DELETE FROM location_tag WHERE name = 'Admission Location' AND description = 'General ward (4th floor)';
DELETE FROM location_tag WHERE name = 'Admission Location' AND description = 'Hospital Wards';
DELETE FROM location_tag WHERE name = 'Admission Location' AND description = 'Kahramana Hotel';
DELETE FROM location_tag WHERE name = 'Admission Location' AND description = 'Rehabilitation center';