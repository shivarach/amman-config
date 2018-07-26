SELECT location_tag_id INTO @admission_location_tag_id FROM location_tag WHERE name = 'Admission Location' AND description = 'Tag for Bed management module' AND retired = FALSE ;

SELECT location_id INTO @ward_parent_location_id FROM location WHERE name = 'Ward' AND description = 'Wards in hospital' AND parent_location IS NULL AND retired = FALSE ;
SELECT location_id INTO @kahramana_parent_location_id FROM location WHERE name = 'Kahramana' AND description = 'Hotel kahramana' AND parent_location IS NULL AND retired = FALSE ;
SELECT location_id INTO @rc_parent_location_id FROM location WHERE name = 'Rehabilitation Center' AND description = 'Rehabilitation Center in Hospital' AND parent_location IS NULL AND retired = FALSE ;

INSERT INTO location_tag_map (location_id, location_tag_id) VALUES (@ward_parent_location_id, @admission_location_tag_id);
INSERT INTO location_tag_map (location_id, location_tag_id) VALUES (@kahramana_parent_location_id, @admission_location_tag_id);
INSERT INTO location_tag_map (location_id, location_tag_id) VALUES (@rc_parent_location_id, @admission_location_tag_id);


