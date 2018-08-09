USE [ResidentalData]
GO

/****** Object:  StoredProcedure [dbo].[spCreateChargeInfo]    Script Date: 09.08.2018 16:55:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spCreateChargeInfo]
	@RowGUID uniqueidentifier,
	@AccountGUID uniqueidentifier,
	@CalculationMonth int,
	@CalculationYear int

AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @IsMeteringDevice  decimal(18,2)
	DECLARE @IsAverageVolume decimal(18,2)
	DECLARE @CalculationResult decimal(18,2)
	DECLARE @CalculationVolume decimal(18,2)
	DECLARE @VolumeDeterminingMethod nvarchar(1)
	DECLARE @MeteringDeviceGUID uniqueidentifier
	DECLARE @ContractSubjectGUID uniqueidentifier

	--/////////���������� ������
	DECLARE ContractSubject_cur CURSOR FOR
		SELECT ContractSubject.GUID
		FROM Accounts
		LEFT JOIN ObjectAddress ON Accounts.ObjectAddressGUID = ObjectAddress.GUID
		LEFT JOIN SupplyResourceContract ON ObjectAddress.SupplyResourceContractGUID = SupplyResourceContract.GUID
		LEFT JOIN ContractSubject ON SupplyResourceContract.GUID = ContractSubject.SupplyResourceContractGUID
		WHERE Accounts.GUID = @AccountGUID
	OPEN ContractSubject_cur
	FETCH NEXT FROM ContractSubject_cur INTO @ContractSubjectGUID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--//////////���������� ��
		DECLARE Calculation_cur CURSOR FOR 
			SELECT MeteringDevice.GUID
			FROM Accounts
			LEFT JOIN ObjectAddress ON Accounts.ObjectAddressGUID = ObjectAddress.GUID
			LEFT JOIN MeteringDevice ON ObjectAddress.GUID = MeteringDevice.ObjectAddressGUID
			WHERE Accounts.GUID = @AccountGUID
		OPEN Calculation_cur
		--��������� ������ ������ ������ � ���� ����������
		FETCH NEXT FROM Calculation_cur INTO @MeteringDeviceGUID
		--���� ������ � ������� ����, �� ������� � ����
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--�� ������ �������� ����� ��������� ���� �������� ��������� � ������� �����������
			SET @IsMeteringDevice = dbo.fnIsMeteringDevice(@MeteringDeviceGUID, @CalculationMonth, @CalculationYear)
			--print @IsMeteringDevice
			IF (@IsMeteringDevice IS NOT NULL)
				BEGIN
					--������ �� ���������� �������
					--SET @CalculationResult = dbo.fnCalculationReading(@IsMeteringDevice, @AccountIndividualServicesGUID)
					SELECT @CalculationResult = Result FROM dbo.fnCalculationReading(@IsMeteringDevice, @ContractSubjectGUID)
					SELECT @CalculationVolume = Volume FROM dbo.fnCalculationReading(@IsMeteringDevice, @ContractSubjectGUID)
					SET @VolumeDeterminingMethod = 'M'
				END
			ELSE
				BEGIN
					SET @IsAverageVolume = dbo.fnIsAverageVolume(@MeteringDeviceGUID, @CalculationMonth, @CalculationYear)
					IF (@IsAverageVolume IS NOT NULL)
						BEGIN
							--������ �� ��������
							--SET @CalculationResult = dbo.fnCalculationAverage(@AccountGUID)
							SELECT @CalculationResult = Result FROM dbo.fnCalculationAverage(@IsAverageVolume, @ContractSubjectGUID)
							SELECT @CalculationVolume = Volume FROM dbo.fnCalculationAverage(@IsAverageVolume, @ContractSubjectGUID)
							SET @VolumeDeterminingMethod = 'O'
						END
					ELSE
						BEGIN
							--������ �� ���������
							--SET @CalculationResult = dbo.fnCalculationStandard(@AccountGUID, @AccountIndividualServicesGUID)
							SELECT @CalculationResult = Result FROM dbo.fnCalculationStandard(@AccountGUID, @ContractSubjectGUID)
							SELECT @CalculationVolume = Volume FROM dbo.fnCalculationStandard(@AccountGUID, @ContractSubjectGUID)
							SET @VolumeDeterminingMethod = 'N'
						END
				END
			
			--��������� ������ ��������
			EXEC dbo.spInsertCalculationData @RowGUID, @ContractSubjectGUID, @MeteringDeviceGUID, @CalculationResult, @CalculationVolume, @VolumeDeterminingMethod
			--��������� ��������� ������ �������
			FETCH NEXT FROM Calculation_cur INTO @MeteringDeviceGUID
		END
		CLOSE Calculation_cur
		DEALLOCATE Calculation_cur
		--/////////////
		FETCH NEXT FROM ContractSubject_cur INTO @ContractSubjectGUID
	END
	CLOSE ContractSubject_cur
	DEALLOCATE ContractSubject_cur

END
GO


