package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func main() {
    http.HandleFunc("/image-urls", func(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Access-Control-Allow-Origin", "*") // CORS対応
        imageUrls := []string{
            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
            "https://images.unsplash.com/photo-1519125323398-675f0ddb6308",
            "https://images.unsplash.com/photo-1465101046530-73398c7f28ca",
            "https://images.unsplash.com/photo-1502082553048-f009c37129b9",
            "https://images.unsplash.com/photo-1519985176271-adb1088fa94c",
            "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
            "https://images.unsplash.com/photo-1465101178521-c1a9136a3b99",
            "https://images.unsplash.com/photo-1519125323398-675f0ddb6308",
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
            "https://images.unsplash.com/photo-1465101046530-73398c7f28ca",
            "https://images.unsplash.com/photo-1502082553048-f009c37129b9",
            "https://images.unsplash.com/photo-1519985176271-adb1088fa94c",
            "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
            "https://images.unsplash.com/photo-1465101178521-c1a9136a3b99",
            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
            "https://images.unsplash.com/photo-1519125323398-675f0ddb6308",
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
            "https://images.unsplash.com/photo-1465101046530-73398c7f28ca",
            "https://images.unsplash.com/photo-1502082553048-f009c37129b9",
        }
        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(imageUrls)
    })

    log.Println("Server is running on http://localhost:8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}