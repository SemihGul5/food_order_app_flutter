# Food Order App Flutter
Bu Flutter uygulaması, bir yemek sipariş sistemi simülasyonu oluşturmak için tasarlanmıştır ve kodun temiz ve düzenli kalmasını sağlamak amacıyla Bloc Pattern kullanmaktadır. Kullanıcılar, uygulama aracılığıyla farklı yemekleri inceleyebilir, sepetlerine ekleyebilir ve favori yemeklerini yönetebilir. Proje, Dart dili kullanılarak geliştirilmiş olup, modern Flutter uygulama geliştirme prensiplerine göre tasarlanmıştır. Aşağıda proje genelinde kullanılan teknolojiler ve yapıların detaylarına yer verilmiştir.

## State Management - Bloc Pattern
 - Bloc/Cubit: Uygulama genelinde state yönetimi sağlamak için Flutter Bloc paketi kullanılmıştır.
 - Temiz kod yapısını desteklemek ve daha iyi bir UI-State ayrımı sağlamak için state yönetimi bileşenleri kullanılmıştır.
## Veritabanı Yönetimi
 - SQLite: Kullanıcıların sepet ve favori verilerini cihazda saklamak için Flutter’ın SQLite paketi entegre edilmiştir.
 - Lokal veritabanı işlemleri için DAO (Data Access Object) yapısına uygun bir mimari benimsenmiştir.
## Ağ İstekleri
 - Dio: Uygulamanın sunucu ile iletişim kurması için Dio kullanılmıştır.
 - API'den alınan yemek listeleri, sipariş detayları gibi veriler JSON formatında işlenmiştir.

https://github.com/user-attachments/assets/d3ad4813-0e6e-41f2-a93b-1c0acdc4fdd9

<table>
  <tr>
    <th>Ana Sayfa</th>
    <th>Yemek Detayı</th>
    <th>Sepet</th>
    <th>Favoriler</th>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/3f493ded-224f-4625-b914-2ea5065d1a6d" alt="anasayfa" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/81d383ff-48d1-4467-9fd5-408152f956c5" alt="yemek_detayı" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/70d26348-351f-4ccd-9708-877090229c0c" alt="sepet" width="250"/></td>
    <td><img src="https://github.com/user-attachments/assets/b8f7df80-27e5-4cdb-b0ce-2bee7ca4ce8f" alt="favoriler" width="250"/></td>
  </tr>
</table>

