all: chat

chat:
	go build -o bin/chat main.go

clean:
	@rm -rf ./bin
	@rm -rf ./out

.PHONY: clean all chat
