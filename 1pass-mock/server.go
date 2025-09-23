package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func healthCheckHandler(c echo.Context) error {
	return c.NoContent(http.StatusNoContent)
}

func vaultsHandler(c echo.Context) error {
	data, err := os.ReadFile("data/vaults.json")
	if err != nil {
		return c.String(http.StatusInternalServerError, "Failed to read vaults.json")
	}
	return c.JSONBlob(http.StatusOK, data)
}

func itemHandler(c echo.Context) error {
	vaultID := c.Param("vault_id")
	itemID := c.Param("item_id")
	log.Printf("Received request for vault_id: %s, item_id: %s", vaultID, itemID)

	data, err := os.ReadFile(fmt.Sprintf("data/%s/%s.json", vaultID, itemID))
	if err != nil {
		return c.String(http.StatusInternalServerError, "Failed to read item.json")
	}
	return c.JSONBlob(http.StatusOK, data)
}

func main() {
	e := echo.New()

	e.Use(middleware.Logger())
	e.GET("/health", healthCheckHandler)
	e.GET("/v1/vaults", vaultsHandler)
	e.GET("/v1/vaults/:vault_id/items/:item_id", itemHandler)

	port := ":8080"
	e.Logger.Infof("Starting server on port %s", port)
	if err := e.Start(port); err != nil {
		e.Logger.Fatal(err)
	}
}
