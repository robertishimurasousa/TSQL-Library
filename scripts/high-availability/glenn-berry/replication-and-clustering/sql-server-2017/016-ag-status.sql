-- TSQL Library: AG Status
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2017 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2017.sql#L582-L606
-- Upstream last modified: August 12, 2025; original query 16.
-- Validation: source integrity and static checks only; see docs/glenn-berry/README.md.
-- License: Glenn Berry terms below; this file is NOT covered by the root MIT license.

--*   Copyright (C) 2025 Glenn Berry
--*   All rights reserved.
--*
--*
--*   You may alter this code for your own *non-commercial* purposes. You may
--*   republish altered code as long as you include this copyright and give due credit.
--*
--*
--*   THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF
--*   ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
--*   TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
--*   PARTICULAR PURPOSE.
--*

-- Good overview of AG health and status (Query 16) (AG Status)
SELECT ag.name AS [AG Name], ar.replica_server_name, ar.availability_mode_desc, adc.[database_name],
       drs.is_local, drs.is_primary_replica, drs.synchronization_state_desc, drs.is_commit_participant,
	   drs.synchronization_health_desc, drs.recovery_lsn, drs.truncation_lsn, drs.last_sent_lsn,
	   drs.last_sent_time, drs.last_received_lsn, drs.last_received_time, drs.last_hardened_lsn,
	   drs.last_hardened_time, drs.last_redone_lsn, drs.last_redone_time, drs.log_send_queue_size,
	   drs.log_send_rate, drs.redo_queue_size, drs.redo_rate, drs.filestream_send_rate,
	   drs.end_of_log_lsn, drs.last_commit_lsn, drs.last_commit_time, drs.database_state_desc
FROM sys.dm_hadr_database_replica_states AS drs WITH (NOLOCK)
INNER JOIN sys.availability_databases_cluster AS adc WITH (NOLOCK)
ON drs.group_id = adc.group_id
AND drs.group_database_id = adc.group_database_id
INNER JOIN sys.availability_groups AS ag WITH (NOLOCK)
ON ag.group_id = drs.group_id
INNER JOIN sys.availability_replicas AS ar WITH (NOLOCK)
ON drs.group_id = ar.group_id
AND drs.replica_id = ar.replica_id
ORDER BY ag.name, ar.replica_server_name, adc.[database_name] OPTION (RECOMPILE);

-- You will see no results if your instance is not using AlwaysOn AGs

-- SQL Server 2016 – It Just Runs Faster: Always On Availability Groups Turbocharged
-- https://bit.ly/2dn1H6r
