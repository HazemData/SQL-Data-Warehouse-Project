EXEC bronze.load_bronze
CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS 
BEGIN
    DECLARE 
        @START_TIME DATETIME,
        @END_TIME DATETIME, 
        @BATCH_START_TIME DATETIME,
        @BATCH_END_TIME DATETIME;

    BEGIN TRY

        SET @BATCH_START_TIME = GETDATE();

        PRINT '================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '================================';

        ------------------------------------------------------
        -- CRM TABLES
        ------------------------------------------------------
        PRINT '--------------------------------';
        PRINT 'LOADING CRM TABLES';
        PRINT '--------------------------------';

        ---------------- crm_cust_info ----------------
        SET @START_TIME = GETDATE();
        PRINT '>> Truncating table : bronze.crm_cust_info'; 
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting into : bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\dw\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' SECONDS';
        PRINT '------------------------------------------';

        ---------------- crm_prd_info ----------------
        SET @START_TIME = GETDATE();
        PRINT '>> Truncating table : bronze.crm_prd_info'; 
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting into : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\dw\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' SECONDS';
        PRINT '------------------------------------------';

        ---------------- crm_sales_details ----------------
        SET @START_TIME = GETDATE();
        PRINT '>> Truncating table : bronze.crm_sales_details'; 
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting into : bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\dw\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' SECONDS';
        PRINT '------------------------------------------';


        ------------------------------------------------------
        -- ERP TABLES
        ------------------------------------------------------
        PRINT '--------------------------------';
        PRINT 'LOADING ERP TABLES';
        PRINT '--------------------------------';

        ---------------- erp_CUST_AZ12 ----------------
        SET @START_TIME = GETDATE();
        PRINT '>> Truncating table : bronze.erp_CUST_AZ12'; 
        TRUNCATE TABLE bronze.erp_CUST_AZ12;

        PRINT '>> Inserting into : bronze.erp_CUST_AZ12';
        BULK INSERT bronze.erp_CUST_AZ12
        FROM 'C:\dw\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' SECONDS';
        PRINT '------------------------------------------';

        ---------------- erp_LOC_A101 ----------------
        SET @START_TIME = GETDATE();
        PRINT '>> Truncating table : bronze.erp_LOC_A101'; 
        TRUNCATE TABLE bronze.erp_LOC_A101;

        PRINT '>> Inserting into : bronze.erp_LOC_A101';
        BULK INSERT bronze.erp_LOC_A101
        FROM 'C:\dw\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' SECONDS';
        PRINT '------------------------------------------';

        ---------------- erp_PX_CAT_G1V2 ----------------
        SET @START_TIME = GETDATE();
        PRINT '>> Truncating table : bronze.erp_PX_CAT_G1V2'; 
        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

        PRINT '>> Inserting into : bronze.erp_PX_CAT_G1V2';
        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM 'C:\dw\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR) + ' SECONDS';
        PRINT '------------------------------------------';

        ------------------------------------------------------
        -- END OF BATCH
        ------------------------------------------------------
        SET @BATCH_END_TIME = GETDATE();

        PRINT '=================================';
        PRINT 'LOADING BRONZE LAYER COMPLETED';
        PRINT 'TOTAL LOAD DURATION : ' + CAST(DATEDIFF(SECOND, @BATCH_START_TIME, @BATCH_END_TIME) AS NVARCHAR) + ' SECONDS';
        PRINT '=================================';

    END TRY 

    BEGIN CATCH
        PRINT '=============================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR STATE  : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '=============================================';
    END CATCH 

END;

