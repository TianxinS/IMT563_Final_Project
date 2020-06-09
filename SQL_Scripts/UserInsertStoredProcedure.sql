--insert user data stored procedure
--to secure user password, we add a randomly generated unique string for the password encryption
ALTER TABLE dbo.Users ADD Salt UNIQUEIDENTIFIER 
GO

ALTER PROCEDURE dbo.uspAddUser
    @pUserName VARCHAR(20), 
    @pPassword VARCHAR(18),
    @pFirstName VARCHAR(20), 
    @pLastName VARCHAR(20),
	@pDateOfBirth DATE = NULL,
	@pEmailAddress VARCHAR(100),
	@pPhoneNumber VARCHAR(20) = NULL,
	@pCreatedDate DATETIME,
	@pCreatedBy VARCHAR(100),
    @responseMessage VARCHAR(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @salt UNIQUEIDENTIFIER=NEWID()
    BEGIN TRY

        INSERT INTO dbo.Users (UserName, Password, Salt, FirstName, LastName, DateOfBirth, EmailAddress, PhoneNumber, CreatedDate, CreatedBy)
        VALUES(@pUserName, HASHBYTES('SHA2_512', @pPassword+CAST(@salt AS NVARCHAR(36))), @salt, @pFirstName, @pLastName, @pDateOfBirth, @pEmailAddress, @pPhoneNumber, GETDATE(), 'System Input')

       SET @responseMessage='Success'

    END TRY
    BEGIN CATCH
        SET @responseMessage=ERROR_MESSAGE() 
    END CATCH

END

--
CREATE PROCEDURE dbo.uspLogin
    @pUserName VARCHAR(20),
    @pPassword VARCHAR(18),
    @responseMessage VARCHAR(250)='' OUTPUT
AS
BEGIN

    SET NOCOUNT ON

    DECLARE @userID INT

    IF EXISTS (SELECT TOP 1 UserID FROM [dbo].[Users] WHERE UserName=@pUserName)
    BEGIN
        SET @userID=(SELECT UserID FROM [dbo].[Users] WHERE UserName=@pUserName AND PasswordHash=HASHBYTES('SHA2_512', @pPassword+CAST(Salt AS NVARCHAR(36))))

        IF(@userID IS NULL)
            SET @responseMessage='Incorrect password'
        ELSE 
            SET @responseMessage='User successfully logged in'
    END
    ELSE
       SET @responseMessage='Invalid user name'

END