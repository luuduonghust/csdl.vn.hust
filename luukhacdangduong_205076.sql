create database dbhousin
go
use dbhousin
go
CREATE TABLE KhachHang
(
    MaKH varchar(10) primary key,
	HoTen nvarchar(30) not null,
	SoDT int not null,
	CoQuan nvarchar(50) not null
	)

CREATE TABLE NhaChoThue
(   
    MaN int primary key,
    DiaChi nvarchar(50) not null,
	GiaThue money not null,
	TenChuNha nvarchar(30) not null
	)

	 
CREATE TABLE HopDong
(   
    MaKH varchar(10),
	MaN int,
    foreign key (MaKH) references dbo.KhachHang(MaKH),
	foreign key (MaN) references dbo.NhaChoThue(MaN),
	NgayBD date not null,
	NgayKT date not null
	)
insert into KhachHang(MaKH,HoTen,SoDT,CoQuan)
VALUES
    ('KH1',N'NGUYỄN THANH LONG','0123445678',N'ĐI TÙ'),
    ('KH2',N'CHU NGỌC ANH','1212121212',N'CON SÂU'),
	('KH3',N'TRỊNH VĂN QUYẾT','300030030',N'NHÀ ĐẦU TƯ'),
	('KH4',N'PHẠM CÔNG TẠC','0786544567',N'THỨ TRƯỞNG'),
	('KH5',N'NGUYỄN MINH TUẤN','0987654321',N'VỤ TRƯỞNG'),
	('KH6',N'NGUYỄN NAM LIÊN','0123456798',N'PHÓ VỤ TRƯỞNG'),
	('KH7',N'TRỊNH THANH HÙNG','0123457689',N'UỶ VIÊN'),
	('KH8',N'NGUYỄ VĂN HIỆU','0879654321',N'ĐẠI TÁ'),
	('KH9',N'HỒ ANH SƠN','0934438977',N'THƯỢNG TÁ'),
	('KH10',N'LÂM VĂN TUẤN','0323422423',N'CDC HÀ GIANG'),
	('KH11',N'HOÀNG VĂN LƯƠNG','0123455678',N'THIẾU TƯỚNG'),
	('KH12',N'ĐỖ ĐỨC LƯU','0112233445',N'CDC NAM ĐỊNH'),
	('KH13',N'NGUYỄN VĂN ĐỊNH','0123467890',N'CDC NGHỆ AN'),
	('KH14',N'HOÀNG VĂN ĐỨC NHẬT','01234567800',N'KẾ TOÁN TRƯỞNG'),
	('KH15',N'LÒ VĂN CHIẾN','0538745834',N'TRƯỞNG KHOA DƯỢC');

INSERT INTO NhaChoThue(MaN,DiaChi,GiaThue,TenChuNha)
VALUES 
    ('1',N'THANH HOÁ',20600000,N'NÔNG VĂN DỀN'),
    ('2',N'NGHỆ AN',5000000,N'QUANG LÊ'),
	('3',N'HÀ TĨNH',11100000,N'LỆ QUYÊN'),
	('4',N'QUẢNG BÌNH',6250000,N'TUẤN HƯNG'),
	('5',N'QUẢNG TRỊ',5010000,N'NGỌC HẠ'),
	('6',N'THỪA THIÊN HUẾ',26000000,N'MĨ TÂM'),
	('7',N'ĐÀ NẴNG',43000000,N'ĐÀM VĨNH HƯNG'),
	('8',N'QUY NHƠN',21000000,N'TRẦN LẬP'),
	('9',N'BÌNH ĐỊNH',2200000,N'ĐAN NGUYÊN'),
	('10',N'PHÚ YÊN',11400000,N'NGỌC SƠN');

INSERT INTO HopDong(MaKH,MaN,NgayBD,NgayKT)
VALUES 
    ('KH1','2','1890-05-19','1969-09-02'),
    ('KH2','4','1945-09-02','2022-01-21'),
	('KH3','2','1975-04-30','2022-02-22'),
	('KH4','7','1930-02-03','2022-03-23'),
	('KH5','10','1945-09-03','2022-04-24'),
	('KH6','2','1945-08-30','2021-05-25'),
	('KH7','1','1946-06-01','2020-06-26'),
	('KH9','1','1931-03-26','2019-07-27'),
	('KH11','8','1945-08-23','2018-08-28'),
	('KH13','3','1995-07-28','2017-12-29');

--b1: Đưa ra danh sách (Địachỉ, Tênchủnhà) của những ngôi nhà có giá thuê ít hơn 10 triệu.
select DiaChi,TenChuNha from NhaChoThue where GiaThue<10000000

--b2: Đưa ra danh sách (MãKH, Họtên, Cơquan) của những người đã từng thuê nhà của chủnhà có tên là "Nông Văn Dền"
select N.MaKH,KH.HoTen,KH.CoQuan from KhachHang as KH inner join
(select HD.MaKH,HD.MaN,NCT.TenChuNha from NhaChoThue as NCT inner join HopDong as HD on NCT.TenChuNha=N'NÔNG VĂN DỀN' and NCT.MaN=HD.MaN ) as N on N.MaKH=KH.MaKH

--b3: Đưa ra danh sách các ngôi nhà chưa từng được ai thuê
select * from NhaChoThue as NCT
except
select NCT1.*from NhaChoThue as NCT1 inner join HopDong as HD on HD.MaN=NCT1.MaN

--b4: Đưa ra giá thuê cao nhất trong số các giá thuê của các ngôi nhà đã từng ít nhất một lần được thuê.
select max(NCT.GiaThue) as GiaMax from NhaChoThue as NCT inner join HopDong as HD on HD.MaN=NCT.MaN

--c1: Viết câu lệnh đưa ra danh sách các khách hàng ở một cơ quan nào đó.
CREATE INDEX INDEX_1 ON KhachHang(MaKH)
SELECT * FROM KhachHang WHERE COQUAN =N'ĐI TÙ'
SET STATISTICS IO ON;
GO

--c2: Đưa ra danh sách các Chủnhàcho thuê và tổng số lượng Nhà cho thuê.
CREATE INDEX INDEX_2 ON NhaChoThue(MaN)
SELECT TenChuNha,COUNT(*) AS SL_NHACHOTHUE FROM NhaChoThue GROUP BY TenChuNha ORDER BY SL_NHACHOTHUE DESC

--d1: Đưa ra danhsách  các  Hợp đồng  có  giá  thuê  lớn hơn một ngưỡng  cho trước.
--d2: Đưa ra danh sách khách hàngcó tổng giá trịhợp đồng lớn hơn một ngưỡng cho trước.
