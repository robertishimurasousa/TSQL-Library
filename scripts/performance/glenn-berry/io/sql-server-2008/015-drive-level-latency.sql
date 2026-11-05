-- TSQL Library: Drive Level Latency
-- Author: Glenn Berry. Adaptation: split and categorized by TSQL Library.
-- Context: master on the target instance
-- Target platform: SQL Server 2008 (upstream suite; not execution-tested).
-- Mode: metadata reads
-- Permissions: Permissions depend on the referenced objects and platform; see docs/glenn-berry/README.md. Minimum grants have not been execution-tested.
-- Notes: Original explanatory comments are retained; dated recommendations are historical. Results may disclose environment details, SQL text, plans or log contents; review before sharing.
-- Reference: https://github.com/Ratithoglys/GlennBerry_DMV_Queries/blob/0e1f8fe7c9664550f74bea7c03a6030cd46afa42/2008.sql#L342-L383
-- Upstream last modified: January 1, 2025; original query 15.
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

-- Drive level latency information (Query 15) (Drive Level Latency)
-- Based on code from Jimmy May
SELECT tab.[Drive],
	CASE
		WHEN num_of_reads = 0 THEN 0
		ELSE (io_stall_read_ms/num_of_reads)
	END AS [Read Latency],
	CASE
		WHEN num_of_writes = 0 THEN 0
		ELSE (io_stall_write_ms/num_of_writes)
	END AS [Write Latency],
	CASE
		WHEN (num_of_reads = 0 AND num_of_writes = 0) THEN 0
		ELSE (io_stall/(num_of_reads + num_of_writes))
	END AS [Overall Latency],
	CASE
		WHEN num_of_reads = 0 THEN 0
		ELSE (num_of_bytes_read/num_of_reads)
	END AS [Avg Bytes/Read],
	CASE
		WHEN num_of_writes = 0 THEN 0
		ELSE (num_of_bytes_written/num_of_writes)
	END AS [Avg Bytes/Write],
	CASE
		WHEN (num_of_reads = 0 AND num_of_writes = 0) THEN 0
		ELSE ((num_of_bytes_read + num_of_bytes_written)/(num_of_reads + num_of_writes))
	END AS [Avg Bytes/Transfer]
FROM (SELECT LEFT(UPPER(mf.physical_name), 2) AS Drive, SUM(num_of_reads) AS num_of_reads,
	         SUM(io_stall_read_ms) AS io_stall_read_ms, SUM(num_of_writes) AS num_of_writes,
	         SUM(io_stall_write_ms) AS io_stall_write_ms, SUM(num_of_bytes_read) AS num_of_bytes_read,
	         SUM(num_of_bytes_written) AS num_of_bytes_written, SUM(io_stall) AS io_stall
      FROM sys.dm_io_virtual_file_stats(NULL, NULL) AS vfs
      INNER JOIN sys.master_files AS mf WITH (NOLOCK)
      ON vfs.database_id = mf.database_id AND vfs.file_id = mf.file_id
      GROUP BY LEFT(UPPER(mf.physical_name), 2)) AS tab
ORDER BY [Overall Latency] OPTION (RECOMPILE);
------

-- Shows you the drive-level latency for reads and writes, in milliseconds
-- Latency above 20-25ms is usually a problem
