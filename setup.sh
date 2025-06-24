#!/bin/bash

echo "Starting project setup..."

# --- Create Directory Structure ---
echo "Creating directories..."
mkdir -p .vscode
mkdir -p src/ai/flows
mkdir -p src/app/'(app)'/article-writer
mkdir -p src/app/'(app)'/code-generator
mkdir -p src/app/'(app)'/content-creation
mkdir -p src/app/'(app)'/dashboard
mkdir -p src/app/'(app)'/email-responder
mkdir -p src/app/'(app)'/image-editor
mkdir -p src/app/'(app)'/math-solver
mkdir -p src/app/'(app)'/report-generator
mkdir -p src/app/'(app)'/resume-writer
mkdir -p src/app/'(app)'/script-writer
mkdir -p src/app/'(app)'/social-media-post-generator
mkdir -p src/app/'(auth)'/login
mkdir -p src/app/'(auth)'/signup
mkdir -p src/components/ui
mkdir -p src/hooks
mkdir -p src/lib

# --- Create Files ---
echo "Creating project files..."

# Root directory files
cat <<'EOF' > .gitignore
# See https://help.github.com/articles/ignoring-files/ for more about ignoring files.

# dependencies
/node_modules
/.pnp
.pnp.js

# testing
/coverage

# next.js
/.next/
/out/

# production
/build

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# local env files
.env.local
.env.development.local
.env.test.local
.env.production.local

# vercel
.vercel

# typescript
*.tsbuildinfo
EOF

cat <<'EOF' > .env
# This file is for reference. For local development,
# rename this file to .env.local and add your key.
# For deployment, add GOOGLE_API_KEY to your hosting provider's
# environment variables.
GOOGLE_API_KEY="YOUR_API_KEY_HERE"
EOF

cat <<'EOF' > apphosting.yaml
# Settings to manage and configure a Firebase App Hosting backend.
# https://firebase.google.com/docs/app-hosting/configure

runConfig:
  # Increase this value if you'd like to automatically spin up
  # more instances in response to increased traffic.
  maxInstances: 1
  # Make the GOOGLE_API_KEY secret available to the app at runtime.
  secrets:
    - secret: GOOGLE_API_KEY
      # Expose the secret as an environment variable with the same name.
      # You can also specify a different name here.
      env: GOOGLE_API_KEY
EOF

cat <<'EOF' > components.json
{
  "$schema": "https://ui.shadcn.com/schema.json",
  "style": "default",
  "rsc": true,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.ts",
    "css": "src/app/globals.css",
    "baseColor": "neutral",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils",
    "ui": "@/components/ui",
    "lib": "@/lib",
    "hooks": "@/hooks"
  },
  "iconLibrary": "lucide"
}
EOF

cat <<'EOF' > next.config.ts
import type {NextConfig} from 'next';

const nextConfig: NextConfig = {
  /* config options here */
  typescript: {
    ignoreBuildErrors: true,
  },
  eslint: {
    ignoreDuringBuilds: true,
  },
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**',
      },
      {
        protocol: 'http',
        hostname: '**',
      },
    ],
    // Allow data URIs
    dangerouslyAllowSVG: true,
    contentSecurityPolicy: "default-src 'self'; script-src 'none'; sandbox;",
  },
};

export default nextConfig;
EOF

cat <<'EOF' > package.json
{
  "name": "nextn",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev --turbopack -p 9002",
    "genkit:dev": "genkit start -- tsx src/ai/dev.ts",
    "genkit:watch": "genkit start -- tsx --watch src/ai/dev.ts",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "typecheck": "tsc --noEmit"
  },
  "dependencies": {
    "@genkit-ai/googleai": "^1.8.0",
    "@genkit-ai/next": "^1.8.0",
    "@hookform/resolvers": "^4.1.3",
    "@radix-ui/react-accordion": "^1.2.3",
    "@radix-ui/react-alert-dialog": "^1.1.6",
    "@radix-ui/react-avatar": "^1.1.3",
    "@radix-ui/react-checkbox": "^1.1.4",
    "@radix-ui/react-dialog": "^1.1.6",
    "@radix-ui/react-dropdown-menu": "^2.1.6",
    "@radix-ui/react-label": "^2.1.2",
    "@radix-ui/react-menubar": "^1.1.6",
    "@radix-ui/react-popover": "^1.1.6",
    "@radix-ui/react-progress": "^1.1.2",
    "@radix-ui/react-radio-group": "^1.2.3",
    "@radix-ui/react-scroll-area": "^1.2.3",
    "@radix-ui/react-select": "^2.1.6",
    "@radix-ui/react-separator": "^1.1.2",
    "@radix-ui/react-slider": "^1.2.3",
    "@radix-ui/react-slot": "^1.1.2",
    "@radix-ui/react-switch": "^1.1.3",
    "@radix-ui/react-tabs": "^1.1.3",
    "@radix-ui/react-toast": "^1.2.6",
    "@radix-ui/react-tooltip": "^1.1.8",
    "class-variance-authority": "^0.7.1",
    "clsx": "^2.1.1",
    "date-fns": "^3.6.0",
    "dotenv": "^16.5.0",
    "firebase": "^11.9.1",
    "framer-motion": "^11.3.19",
    "genkit": "^1.8.0",
    "lucide-react": "^0.475.0",
    "next": "15.3.3",
    "patch-package": "^8.0.0",
    "react": "^18.3.1",
    "react-day-picker": "^8.10.1",
    "react-dom": "^18.3.1",
    "react-hook-form": "^7.54.2",
    "recharts": "^2.15.1",
    "tailwind-merge": "^3.0.1",
    "tailwindcss-animate": "^1.0.7",
    "zod": "^3.24.2"
  },
  "devDependencies": {
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "genkit-cli": "^1.8.0",
    "postcss": "^8",
    "tailwindcss": "^3.4.1",
    "typescript": "^5"
  }
}
EOF

cat <<'EOF' > README.md
# Keizer AI Suite - How to Get Started

Your app is almost ready! To make the AI tools work, you just need to do one last thing: add your free Google AI API key.

It's a simple copy-and-paste. Here's how:

## Step 1: Get Your API Key

1.  **Click this link to go to Google AI Studio:** [https://aistudio.google.com/app/apikey](https://aistudio.google.com/app/apikey)
2.  Click the **"Create API key"** button.
3.  **Copy** the key it gives you.

## Step 2: Add the Key to Your App

1.  In the file list on the left, find the file named **`.env`**.
2.  **Rename** that file to **`.env.local`**.
3.  **Open** the new `.env.local` file.
4.  You will see the line `GOOGLE_API_KEY="YOUR_API_KEY_HERE"`.
5.  **Replace** the text `"YOUR_API_KEY_HERE"` with the key you copied from Google. Make sure to keep the quotes!

That's it! Your app will now have full access to all the AI features.
EOF

cat <<'EOF' > tailwind.config.ts
import type {Config} from 'tailwindcss';

export default {
  darkMode: ['class'],
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      fontFamily: {
        body: ['var(--font-body)', 'sans-serif'],
        headline: ['var(--font-headline)', 'sans-serif'],
        code: ['monospace'],
      },
      colors: {
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        card: {
          DEFAULT: 'hsl(var(--card))',
          foreground: 'hsl(var(--card-foreground))',
        },
        popover: {
          DEFAULT: 'hsl(var(--popover))',
          foreground: 'hsl(var(--popover-foreground))',
        },
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))',
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))',
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))',
        },
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))',
        },
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        chart: {
          '1': 'hsl(var(--chart-1))',
          '2': 'hsl(var(--chart-2))',
          '3': 'hsl(var(--chart-3))',
          '4': 'hsl(var(--chart-4))',
          '5': 'hsl(var(--chart-5))',
        },
        sidebar: {
          DEFAULT: 'hsl(var(--sidebar-background))',
          foreground: 'hsl(var(--sidebar-foreground))',
          primary: 'hsl(var(--sidebar-primary))',
          'primary-foreground': 'hsl(var(--sidebar-primary-foreground))',
          accent: 'hsl(var(--sidebar-accent))',
          'accent-foreground': 'hsl(var(--sidebar-accent-foreground))',
          border: 'hsl(var(--sidebar-border))',
          ring: 'hsl(var(--sidebar-ring))',
        },
      },
      borderRadius: {
        lg: 'var(--radius)',
        md: 'calc(var(--radius) - 2px)',
        sm: 'calc(var(--radius) - 4px)',
      },
      keyframes: {
        'accordion-down': {
          from: {
            height: '0',
          },
          to: {
            height: 'var(--radix-accordion-content-height)',
          },
        },
        'accordion-up': {
          from: {
            height: 'var(--radix-accordion-content-height)',
          },
          to: {
            height: '0',
          },
        },
      },
      animation: {
        'accordion-down': 'accordion-down 0.2s ease-out',
        'accordion-up': 'accordion-up 0.2s ease-out',
      },
    },
  },
  plugins: [require('tailwindcss-animate')],
} satisfies Config;
EOF

cat <<'EOF' > tsconfig.json
{
  "compilerOptions": {
    "target": "ES2017",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

# .vscode directory
cat <<'EOF' > .vscode/settings.json
{
    "IDX.aI.enableInlineCompletion": true,
    "IDX.aI.enableCodebaseIndexing": true
}
EOF

# src directory files
cat <<'EOF' > src/lib/utils.ts
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
EOF

# src/hooks
cat <<'EOF' > src/hooks/use-mobile.tsx
import * as React from "react"

const MOBILE_BREAKPOINT = 768

export function useIsMobile() {
  const [isMobile, setIsMobile] = React.useState<boolean | undefined>(undefined)

  React.useEffect(() => {
    const mql = window.matchMedia(`(max-width: ${MOBILE_BREAKPOINT - 1}px)`)
    const onChange = () => {
      setIsMobile(window.innerWidth < MOBILE_BREAKPOINT)
    }
    mql.addEventListener("change", onChange)
    setIsMobile(window.innerWidth < MOBILE_BREAKPOINT)
    return () => mql.removeEventListener("change", onChange)
  }, [])

  return !!isMobile
}
EOF

cat <<'EOF' > src/hooks/use-toast.ts
"use client"

// Inspired by react-hot-toast library
import * as React from "react"

import type {
  ToastActionElement,
  ToastProps,
} from "@/components/ui/toast"

const TOAST_LIMIT = 1
const TOAST_REMOVE_DELAY = 1000000

type ToasterToast = ToastProps & {
  id: string
  title?: React.ReactNode
  description?: React.ReactNode
  action?: ToastActionElement
}

const actionTypes = {
  ADD_TOAST: "ADD_TOAST",
  UPDATE_TOAST: "UPDATE_TOAST",
  DISMISS_TOAST: "DISMISS_TOAST",
  REMOVE_TOAST: "REMOVE_TOAST",
} as const

let count = 0

function genId() {
  count = (count + 1) % Number.MAX_SAFE_INTEGER
  return count.toString()
}

type ActionType = typeof actionTypes

type Action =
  | {
      type: ActionType["ADD_TOAST"]
      toast: ToasterToast
    }
  | {
      type: ActionType["UPDATE_TOAST"]
      toast: Partial<ToasterToast>
    }
  | {
      type: ActionType["DISMISS_TOAST"]
      toastId?: ToasterToast["id"]
    }
  | {
      type: ActionType["REMOVE_TOAST"]
      toastId?: ToasterToast["id"]
    }

interface State {
  toasts: ToasterToast[]
}

const toastTimeouts = new Map<string, ReturnType<typeof setTimeout>>()

const addToRemoveQueue = (toastId: string) => {
  if (toastTimeouts.has(toastId)) {
    return
  }

  const timeout = setTimeout(() => {
    toastTimeouts.delete(toastId)
    dispatch({
      type: "REMOVE_TOAST",
      toastId: toastId,
    })
  }, TOAST_REMOVE_DELAY)

  toastTimeouts.set(toastId, timeout)
}

export const reducer = (state: State, action: Action): State => {
  switch (action.type) {
    case "ADD_TOAST":
      return {
        ...state,
        toasts: [action.toast, ...state.toasts].slice(0, TOAST_LIMIT),
      }

    case "UPDATE_TOAST":
      return {
        ...state,
        toasts: state.toasts.map((t) =>
          t.id === action.toast.id ? { ...t, ...action.toast } : t
        ),
      }

    case "DISMISS_TOAST": {
      const { toastId } = action

      // ! Side effects ! - This could be extracted into a dismissToast() action,
      // but I'll keep it here for simplicity
      if (toastId) {
        addToRemoveQueue(toastId)
      } else {
        state.toasts.forEach((toast) => {
          addToRemoveQueue(toast.id)
        })
      }

      return {
        ...state,
        toasts: state.toasts.map((t) =>
          t.id === toastId || toastId === undefined
            ? {
                ...t,
                open: false,
              }
            : t
        ),
      }
    }
    case "REMOVE_TOAST":
      if (action.toastId === undefined) {
        return {
          ...state,
          toasts: [],
        }
      }
      return {
        ...state,
        toasts: state.toasts.filter((t) => t.id !== action.toastId),
      }
  }
}

const listeners: Array<(state: State) => void> = []

let memoryState: State = { toasts: [] }

function dispatch(action: Action) {
  memoryState = reducer(memoryState, action)
  listeners.forEach((listener) => {
    listener(memoryState)
  })
}

type Toast = Omit<ToasterToast, "id">

function toast({ ...props }: Toast) {
  const id = genId()

  const update = (props: ToasterToast) =>
    dispatch({
      type: "UPDATE_TOAST",
      toast: { ...props, id },
    })
  const dismiss = () => dispatch({ type: "DISMISS_TOAST", toastId: id })

  dispatch({
    type: "ADD_TOAST",
    toast: {
      ...props,
      id,
      open: true,
      onOpenChange: (open) => {
        if (!open) dismiss()
      },
    },
  })

  return {
    id: id,
    dismiss,
    update,
  }
}

function useToast() {
  const [state, setState] = React.useState<State>(memoryState)

  React.useEffect(() => {
    listeners.push(setState)
    return () => {
      const index = listeners.indexOf(setState)
      if (index > -1) {
        listeners.splice(index, 1)
      }
    }
  }, [state])

  return {
    ...state,
    toast,
    dismiss: (toastId?: string) => dispatch({ type: "DISMISS_TOAST", toastId }),
  }
}

export { useToast, toast }
EOF

# src/components
cat <<'EOF' > src/components/keizer-logo.tsx
import * as React from 'react';

export const KeizerLogo = (props: React.SVGProps<SVGSVGElement>) => (
  <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg" {...props}>
    <g clipPath="url(#clip0_104_2)">
      <path d="M6 4H10L17 12.016L22 4H26L18.5 16L26 28H22L17 19.984L10.016 28H6L13.5 16L6 4Z" fill="url(#paint0_linear_104_2)"/>
    </g>
    <defs>
      <linearGradient id="paint0_linear_104_2" x1="6" y1="4" x2="26" y2="28" gradientUnits="userSpaceOnUse">
        <stop stopColor="#7f3f98"/>
        <stop offset="1" stopColor="#52dc54"/>
      </linearGradient>
      <clipPath id="clip0_104_2">
        <rect width="32" height="32" rx="8" fill="white"/>
      </clipPath>
    </defs>
  </svg>
);
EOF

cat <<'EOF' > src/components/loading-spinner.tsx
import { cn } from "@/lib/utils";

export const LoadingSpinner = ({ className }: { className?: string }) => (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    width="24"
    height="24"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
    className={cn("animate-spin", className)}
  >
    <path d="M21 12a9 9 0 1 1-6.219-8.56" />
  </svg>
);
EOF

# src/components/ui
cat <<'EOF' > src/components/ui/accordion.tsx
"use client"

import * as React from "react"
import * as AccordionPrimitive from "@radix-ui/react-accordion"
import { ChevronDown } from "lucide-react"

import { cn } from "@/lib/utils"

const Accordion = AccordionPrimitive.Root

const AccordionItem = React.forwardRef<
  React.ElementRef<typeof AccordionPrimitive.Item>,
  React.ComponentPropsWithoutRef<typeof AccordionPrimitive.Item>
>(({ className, ...props }, ref) => (
  <AccordionPrimitive.Item
    ref={ref}
    className={cn("border-b", className)}
    {...props}
  />
))
AccordionItem.displayName = "AccordionItem"

const AccordionTrigger = React.forwardRef<
  React.ElementRef<typeof AccordionPrimitive.Trigger>,
  React.ComponentPropsWithoutRef<typeof AccordionPrimitive.Trigger>
>(({ className, children, ...props }, ref) => (
  <AccordionPrimitive.Header className="flex">
    <AccordionPrimitive.Trigger
      ref={ref}
      className={cn(
        "flex flex-1 items-center justify-between py-4 font-medium transition-all hover:underline [&[data-state=open]>svg]:rotate-180",
        className
      )}
      {...props}
    >
      {children}
      <ChevronDown className="h-4 w-4 shrink-0 transition-transform duration-200" />
    </AccordionPrimitive.Trigger>
  </AccordionPrimitive.Header>
))
AccordionTrigger.displayName = AccordionPrimitive.Trigger.displayName

const AccordionContent = React.forwardRef<
  React.ElementRef<typeof AccordionPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof AccordionPrimitive.Content>
>(({ className, children, ...props }, ref) => (
  <AccordionPrimitive.Content
    ref={ref}
    className="overflow-hidden text-sm transition-all data-[state=closed]:animate-accordion-up data-[state=open]:animate-accordion-down"
    {...props}
  >
    <div className={cn("pb-4 pt-0", className)}>{children}</div>
  </AccordionPrimitive.Content>
))

AccordionContent.displayName = AccordionPrimitive.Content.displayName

export { Accordion, AccordionItem, AccordionTrigger, AccordionContent }
EOF

cat <<'EOF' > src/components/ui/alert-dialog.tsx
"use client"

import * as React from "react"
import * as AlertDialogPrimitive from "@radix-ui/react-alert-dialog"

import { cn } from "@/lib/utils"
import { buttonVariants } from "@/components/ui/button"

const AlertDialog = AlertDialogPrimitive.Root

const AlertDialogTrigger = AlertDialogPrimitive.Trigger

const AlertDialogPortal = AlertDialogPrimitive.Portal

const AlertDialogOverlay = React.forwardRef<
  React.ElementRef<typeof AlertDialogPrimitive.Overlay>,
  React.ComponentPropsWithoutRef<typeof AlertDialogPrimitive.Overlay>
>(({ className, ...props }, ref) => (
  <AlertDialogPrimitive.Overlay
    className={cn(
      "fixed inset-0 z-50 bg-black/80  data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0",
      className
    )}
    {...props}
    ref={ref}
  />
))
AlertDialogOverlay.displayName = AlertDialogPrimitive.Overlay.displayName

const AlertDialogContent = React.forwardRef<
  React.ElementRef<typeof AlertDialogPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof AlertDialogPrimitive.Content>
>(({ className, ...props }, ref) => (
  <AlertDialogPortal>
    <AlertDialogOverlay />
    <AlertDialogPrimitive.Content
      ref={ref}
      className={cn(
        "fixed left-[50%] top-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 border bg-background p-6 shadow-lg duration-200 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%] sm:rounded-lg",
        className
      )}
      {...props}
    />
  </AlertDialogPortal>
))
AlertDialogContent.displayName = AlertDialogPrimitive.Content.displayName

const AlertDialogHeader = ({
  className,
  ...props
}: React.HTMLAttributes<HTMLDivElement>) => (
  <div
    className={cn(
      "flex flex-col space-y-2 text-center sm:text-left",
      className
    )}
    {...props}
  />
)
AlertDialogHeader.displayName = "AlertDialogHeader"

const AlertDialogFooter = ({
  className,
  ...props
}: React.HTMLAttributes<HTMLDivElement>) => (
  <div
    className={cn(
      "flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2",
      className
    )}
    {...props}
  />
)
AlertDialogFooter.displayName = "AlertDialogFooter"

const AlertDialogTitle = React.forwardRef<
  React.ElementRef<typeof AlertDialogPrimitive.Title>,
  React.ComponentPropsWithoutRef<typeof AlertDialogPrimitive.Title>
>(({ className, ...props }, ref) => (
  <AlertDialogPrimitive.Title
    ref={ref}
    className={cn("text-lg font-semibold", className)}
    {...props}
  />
))
AlertDialogTitle.displayName = AlertDialogPrimitive.Title.displayName

const AlertDialogDescription = React.forwardRef<
  React.ElementRef<typeof AlertDialogPrimitive.Description>,
  React.ComponentPropsWithoutRef<typeof AlertDialogPrimitive.Description>
>(({ className, ...props }, ref) => (
  <AlertDialogPrimitive.Description
    ref={ref}
    className={cn("text-sm text-muted-foreground", className)}
    {...props}
  />
))
AlertDialogDescription.displayName =
  AlertDialogPrimitive.Description.displayName

const AlertDialogAction = React.forwardRef<
  React.ElementRef<typeof AlertDialogPrimitive.Action>,
  React.ComponentPropsWithoutRef<typeof AlertDialogPrimitive.Action>
>(({ className, ...props }, ref) => (
  <AlertDialogPrimitive.Action
    ref={ref}
    className={cn(buttonVariants(), className)}
    {...props}
  />
))
AlertDialogAction.displayName = AlertDialogPrimitive.Action.displayName

const AlertDialogCancel = React.forwardRef<
  React.ElementRef<typeof AlertDialogPrimitive.Cancel>,
  React.ComponentPropsWithoutRef<typeof AlertDialogPrimitive.Cancel>
>(({ className, ...props }, ref) => (
  <AlertDialogPrimitive.Cancel
    ref={ref}
    className={cn(
      buttonVariants({ variant: "outline" }),
      "mt-2 sm:mt-0",
      className
    )}
    {...props}
  />
))
AlertDialogCancel.displayName = AlertDialogPrimitive.Cancel.displayName

export {
  AlertDialog,
  AlertDialogPortal,
  AlertDialogOverlay,
  AlertDialogTrigger,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogFooter,
  AlertDialogTitle,
  AlertDialogDescription,
  AlertDialogAction,
  AlertDialogCancel,
}
EOF

cat <<'EOF' > src/components/ui/alert.tsx
import * as React from "react"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const alertVariants = cva(
  "relative w-full rounded-lg border p-4 [&>svg~*]:pl-7 [&>svg+div]:translate-y-[-3px] [&>svg]:absolute [&>svg]:left-4 [&>svg]:top-4 [&>svg]:text-foreground",
  {
    variants: {
      variant: {
        default: "bg-background text-foreground",
        destructive:
          "border-destructive/50 text-destructive dark:border-destructive [&>svg]:text-destructive",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
)

const Alert = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement> & VariantProps<typeof alertVariants>
>(({ className, variant, ...props }, ref) => (
  <div
    ref={ref}
    role="alert"
    className={cn(alertVariants({ variant }), className)}
    {...props}
  />
))
Alert.displayName = "Alert"

const AlertTitle = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLHeadingElement>
>(({ className, ...props }, ref) => (
  <h5
    ref={ref}
    className={cn("mb-1 font-medium leading-none tracking-tight", className)}
    {...props}
  />
))
AlertTitle.displayName = "AlertTitle"

const AlertDescription = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLParagraphElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn("text-sm [&_p]:leading-relaxed", className)}
    {...props}
  />
))
AlertDescription.displayName = "AlertDescription"

export { Alert, AlertTitle, AlertDescription }
EOF

cat <<'EOF' > src/components/ui/avatar.tsx
"use client"

import * as React from "react"
import * as AvatarPrimitive from "@radix-ui/react-avatar"

import { cn } from "@/lib/utils"

const Avatar = React.forwardRef<
  React.ElementRef<typeof AvatarPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof AvatarPrimitive.Root>
>(({ className, ...props }, ref) => (
  <AvatarPrimitive.Root
    ref={ref}
    className={cn(
      "relative flex h-10 w-10 shrink-0 overflow-hidden rounded-full",
      className
    )}
    {...props}
  />
))
Avatar.displayName = AvatarPrimitive.Root.displayName

const AvatarImage = React.forwardRef<
  React.ElementRef<typeof AvatarPrimitive.Image>,
  React.ComponentPropsWithoutRef<typeof AvatarPrimitive.Image>
>(({ className, ...props }, ref) => (
  <AvatarPrimitive.Image
    ref={ref}
    className={cn("aspect-square h-full w-full", className)}
    {...props}
  />
))
AvatarImage.displayName = AvatarPrimitive.Image.displayName

const AvatarFallback = React.forwardRef<
  React.ElementRef<typeof AvatarPrimitive.Fallback>,
  React.ComponentPropsWithoutRef<typeof AvatarPrimitive.Fallback>
>(({ className, ...props }, ref) => (
  <AvatarPrimitive.Fallback
    ref={ref}
    className={cn(
      "flex h-full w-full items-center justify-center rounded-full bg-muted",
      className
    )}
    {...props}
  />
))
AvatarFallback.displayName = AvatarPrimitive.Fallback.displayName

export { Avatar, AvatarImage, AvatarFallback }
EOF

cat <<'EOF' > src/components/ui/badge.tsx
import * as React from "react"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const badgeVariants = cva(
  "inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2",
  {
    variants: {
      variant: {
        default:
          "border-transparent bg-primary text-primary-foreground hover:bg-primary/80",
        secondary:
          "border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80",
        destructive:
          "border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80",
        outline: "text-foreground",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
)

export interface BadgeProps
  extends React.HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof badgeVariants> {}

function Badge({ className, variant, ...props }: BadgeProps) {
  return (
    <div className={cn(badgeVariants({ variant }), className)} {...props} />
  )
}

export { Badge, badgeVariants }
EOF

cat <<'EOF' > src/components/ui/button.tsx
import * as React from "react"
import { Slot } from "@radix-ui/react-slot"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/90",
        destructive:
          "bg-destructive text-destructive-foreground hover:bg-destructive/90",
        outline:
          "border border-input bg-background hover:bg-accent hover:text-accent-foreground",
        secondary:
          "bg-secondary text-secondary-foreground hover:bg-secondary/80",
        ghost: "hover:bg-accent hover:text-accent-foreground",
        link: "text-primary underline-offset-4 hover:underline",
      },
      size: {
        default: "h-10 px-4 py-2",
        sm: "h-9 rounded-md px-3",
        lg: "h-11 rounded-md px-8",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : "button"
    return (
      <Comp
        className={cn(buttonVariants({ variant, size, className }))}
        ref={ref}
        {...props}
      />
    )
  }
)
Button.displayName = "Button"

export { Button, buttonVariants }
EOF

cat <<'EOF' > src/components/ui/calendar.tsx
"use client"

import * as React from "react"
import { ChevronLeft, ChevronRight } from "lucide-react"
import { DayPicker } from "react-day-picker"

import { cn } from "@/lib/utils"
import { buttonVariants } from "@/components/ui/button"

export type CalendarProps = React.ComponentProps<typeof DayPicker>

function Calendar({
  className,
  classNames,
  showOutsideDays = true,
  ...props
}: CalendarProps) {
  return (
    <DayPicker
      showOutsideDays={showOutsideDays}
      className={cn("p-3", className)}
      classNames={{
        months: "flex flex-col sm:flex-row space-y-4 sm:space-x-4 sm:space-y-0",
        month: "space-y-4",
        caption: "flex justify-center pt-1 relative items-center",
        caption_label: "text-sm font-medium",
        nav: "space-x-1 flex items-center",
        nav_button: cn(
          buttonVariants({ variant: "outline" }),
          "h-7 w-7 bg-transparent p-0 opacity-50 hover:opacity-100"
        ),
        nav_button_previous: "absolute left-1",
        nav_button_next: "absolute right-1",
        table: "w-full border-collapse space-y-1",
        head_row: "flex",
        head_cell:
          "text-muted-foreground rounded-md w-9 font-normal text-[0.8rem]",
        row: "flex w-full mt-2",
        cell: "h-9 w-9 text-center text-sm p-0 relative [&:has([aria-selected].day-range-end)]:rounded-r-md [&:has([aria-selected].day-outside)]:bg-accent/50 [&:has([aria-selected])]:bg-accent first:[&:has([aria-selected])]:rounded-l-md last:[&:has([aria-selected])]:rounded-r-md focus-within:relative focus-within:z-20",
        day: cn(
          buttonVariants({ variant: "ghost" }),
          "h-9 w-9 p-0 font-normal aria-selected:opacity-100"
        ),
        day_range_end: "day-range-end",
        day_selected:
          "bg-primary text-primary-foreground hover:bg-primary hover:text-primary-foreground focus:bg-primary focus:text-primary-foreground",
        day_today: "bg-accent text-accent-foreground",
        day_outside:
          "day-outside text-muted-foreground aria-selected:bg-accent/50 aria-selected:text-muted-foreground",
        day_disabled: "text-muted-foreground opacity-50",
        day_range_middle:
          "aria-selected:bg-accent aria-selected:text-accent-foreground",
        day_hidden: "invisible",
        ...classNames,
      }}
      components={{
        IconLeft: ({ className, ...props }) => (
          <ChevronLeft className={cn("h-4 w-4", className)} {...props} />
        ),
        IconRight: ({ className, ...props }) => (
          <ChevronRight className={cn("h-4 w-4", className)} {...props} />
        ),
      }}
      {...props}
    />
  )
}
Calendar.displayName = "Calendar"

export { Calendar }
EOF

cat <<'EOF' > src/components/ui/card.tsx
import * as React from "react"

import { cn } from "@/lib/utils"

const Card = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn(
      "rounded-lg border bg-card text-card-foreground shadow-lg transition-all duration-300 hover:border-primary/50 hover:shadow-primary/20",
      className
    )}
    {...props}
  />
))
Card.displayName = "Card"

const CardHeader = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn("flex flex-col space-y-1.5 p-6", className)}
    {...props}
  />
))
CardHeader.displayName = "CardHeader"

const CardTitle = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLHeadingElement>
>(({ className, ...props }, ref) => (
  <h3
    ref={ref}
    className={cn(
      "text-2xl font-semibold leading-none tracking-tight",
      className
    )}
    {...props}
  />
))
CardTitle.displayName = "CardTitle"

const CardDescription = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLParagraphElement>
>(({ className, ...props }, ref) => (
  <p
    ref={ref}
    className={cn("text-sm text-muted-foreground", className)}
    {...props}
  />
))
CardDescription.displayName = "CardDescription"

const CardContent = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div ref={ref} className={cn("p-6 pt-0", className)} {...props} />
))
CardContent.displayName = "CardContent"

const CardFooter = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn("flex items-center p-6 pt-0", className)}
    {...props}
  />
))
CardFooter.displayName = "CardFooter"

export { Card, CardHeader, CardFooter, CardTitle, CardDescription, CardContent }
EOF

cat <<'EOF' > src/components/ui/chart.tsx
"use client"

import * as React from "react"
import * as RechartsPrimitive from "recharts"

import { cn } from "@/lib/utils"

// Format: { THEME_NAME: CSS_SELECTOR }
const THEMES = { light: "", dark: ".dark" } as const

export type ChartConfig = {
  [k in string]: {
    label?: React.ReactNode
    icon?: React.ComponentType
  } & (
    | { color?: string; theme?: never }
    | { color?: never; theme: Record<keyof typeof THEMES, string> }
  )
}

type ChartContextProps = {
  config: ChartConfig
}

const ChartContext = React.createContext<ChartContextProps | null>(null)

function useChart() {
  const context = React.useContext(ChartContext)

  if (!context) {
    throw new Error("useChart must be used within a <ChartContainer />")
  }

  return context
}

const ChartContainer = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div"> & {
    config: ChartConfig
    children: React.ComponentProps<
      typeof RechartsPrimitive.ResponsiveContainer
    >["children"]
  }
>(({ id, className, children, config, ...props }, ref) => {
  const uniqueId = React.useId()
  const chartId = `chart-${id || uniqueId.replace(/:/g, "")}`

  return (
    <ChartContext.Provider value={{ config }}>
      <div
        data-chart={chartId}
        ref={ref}
        className={cn(
          "flex aspect-video justify-center text-xs [&_.recharts-cartesian-axis-tick_text]:fill-muted-foreground [&_.recharts-cartesian-grid_line[stroke='#ccc']]:stroke-border/50 [&_.recharts-curve.recharts-tooltip-cursor]:stroke-border [&_.recharts-dot[stroke='#fff']]:stroke-transparent [&_.recharts-layer]:outline-none [&_.recharts-polar-grid_[stroke='#ccc']]:stroke-border [&_.recharts-radial-bar-background-sector]:fill-muted [&_.recharts-rectangle.recharts-tooltip-cursor]:fill-muted [&_.recharts-reference-line_[stroke='#ccc']]:stroke-border [&_.recharts-sector[stroke='#fff']]:stroke-transparent [&_.recharts-sector]:outline-none [&_.recharts-surface]:outline-none",
          className
        )}
        {...props}
      >
        <ChartStyle id={chartId} config={config} />
        <RechartsPrimitive.ResponsiveContainer>
          {children}
        </RechartsPrimitive.ResponsiveContainer>
      </div>
    </ChartContext.Provider>
  )
})
ChartContainer.displayName = "Chart"

const ChartStyle = ({ id, config }: { id: string; config: ChartConfig }) => {
  const colorConfig = Object.entries(config).filter(
    ([, config]) => config.theme || config.color
  )

  if (!colorConfig.length) {
    return null
  }

  return (
    <style
      dangerouslySetInnerHTML={{
        __html: Object.entries(THEMES)
          .map(
            ([theme, prefix]) => `
${prefix} [data-chart=${id}] {
${colorConfig
  .map(([key, itemConfig]) => {
    const color =
      itemConfig.theme?.[theme as keyof typeof itemConfig.theme] ||
      itemConfig.color
    return color ? `  --color-${key}: ${color};` : null
  })
  .join("\n")}
}
`
          )
          .join("\n"),
      }}
    />
  )
}

const ChartTooltip = RechartsPrimitive.Tooltip

const ChartTooltipContent = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<typeof RechartsPrimitive.Tooltip> &
    React.ComponentProps<"div"> & {
      hideLabel?: boolean
      hideIndicator?: boolean
      indicator?: "line" | "dot" | "dashed"
      nameKey?: string
      labelKey?: string
    }
>(
  (
    {
      active,
      payload,
      className,
      indicator = "dot",
      hideLabel = false,
      hideIndicator = false,
      label,
      labelFormatter,
      labelClassName,
      formatter,
      color,
      nameKey,
      labelKey,
    },
    ref
  ) => {
    const { config } = useChart()

    const tooltipLabel = React.useMemo(() => {
      if (hideLabel || !payload?.length) {
        return null
      }

      const [item] = payload
      const key = `${labelKey || item.dataKey || item.name || "value"}`
      const itemConfig = getPayloadConfigFromPayload(config, item, key)
      const value =
        !labelKey && typeof label === "string"
          ? config[label as keyof typeof config]?.label || label
          : itemConfig?.label

      if (labelFormatter) {
        return (
          <div className={cn("font-medium", labelClassName)}>
            {labelFormatter(value, payload)}
          </div>
        )
      }

      if (!value) {
        return null
      }

      return <div className={cn("font-medium", labelClassName)}>{value}</div>
    }, [
      label,
      labelFormatter,
      payload,
      hideLabel,
      labelClassName,
      config,
      labelKey,
    ])

    if (!active || !payload?.length) {
      return null
    }

    const nestLabel = payload.length === 1 && indicator !== "dot"

    return (
      <div
        ref={ref}
        className={cn(
          "grid min-w-[8rem] items-start gap-1.5 rounded-lg border border-border/50 bg-background px-2.5 py-1.5 text-xs shadow-xl",
          className
        )}
      >
        {!nestLabel ? tooltipLabel : null}
        <div className="grid gap-1.5">
          {payload.map((item, index) => {
            const key = `${nameKey || item.name || item.dataKey || "value"}`
            const itemConfig = getPayloadConfigFromPayload(config, item, key)
            const indicatorColor = color || item.payload.fill || item.color

            return (
              <div
                key={item.dataKey}
                className={cn(
                  "flex w-full flex-wrap items-stretch gap-2 [&>svg]:h-2.5 [&>svg]:w-2.5 [&>svg]:text-muted-foreground",
                  indicator === "dot" && "items-center"
                )}
              >
                {formatter && item?.value !== undefined && item.name ? (
                  formatter(item.value, item.name, item, index, item.payload)
                ) : (
                  <>
                    {itemConfig?.icon ? (
                      <itemConfig.icon />
                    ) : (
                      !hideIndicator && (
                        <div
                          className={cn(
                            "shrink-0 rounded-[2px] border-[--color-border] bg-[--color-bg]",
                            {
                              "h-2.5 w-2.5": indicator === "dot",
                              "w-1": indicator === "line",
                              "w-0 border-[1.5px] border-dashed bg-transparent":
                                indicator === "dashed",
                              "my-0.5": nestLabel && indicator === "dashed",
                            }
                          )}
                          style={
                            {
                              "--color-bg": indicatorColor,
                              "--color-border": indicatorColor,
                            } as React.CSSProperties
                          }
                        />
                      )
                    )}
                    <div
                      className={cn(
                        "flex flex-1 justify-between leading-none",
                        nestLabel ? "items-end" : "items-center"
                      )}
                    >
                      <div className="grid gap-1.5">
                        {nestLabel ? tooltipLabel : null}
                        <span className="text-muted-foreground">
                          {itemConfig?.label || item.name}
                        </span>
                      </div>
                      {item.value && (
                        <span className="font-mono font-medium tabular-nums text-foreground">
                          {item.value.toLocaleString()}
                        </span>
                      )}
                    </div>
                  </>
                )}
              </div>
            )
          })}
        </div>
      </div>
    )
  }
)
ChartTooltipContent.displayName = "ChartTooltip"

const ChartLegend = RechartsPrimitive.Legend

const ChartLegendContent = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div"> &
    Pick<RechartsPrimitive.LegendProps, "payload" | "verticalAlign"> & {
      hideIcon?: boolean
      nameKey?: string
    }
>(
  (
    { className, hideIcon = false, payload, verticalAlign = "bottom", nameKey },
    ref
  ) => {
    const { config } = useChart()

    if (!payload?.length) {
      return null
    }

    return (
      <div
        ref={ref}
        className={cn(
          "flex items-center justify-center gap-4",
          verticalAlign === "top" ? "pb-3" : "pt-3",
          className
        )}
      >
        {payload.map((item) => {
          const key = `${nameKey || item.dataKey || "value"}`
          const itemConfig = getPayloadConfigFromPayload(config, item, key)

          return (
            <div
              key={item.value}
              className={cn(
                "flex items-center gap-1.5 [&>svg]:h-3 [&>svg]:w-3 [&>svg]:text-muted-foreground"
              )}
            >
              {itemConfig?.icon && !hideIcon ? (
                <itemConfig.icon />
              ) : (
                <div
                  className="h-2 w-2 shrink-0 rounded-[2px]"
                  style={{
                    backgroundColor: item.color,
                  }}
                />
              )}
              {itemConfig?.label}
            </div>
          )
        })}
      </div>
    )
  }
)
ChartLegendContent.displayName = "ChartLegend"

// Helper to extract item config from a payload.
function getPayloadConfigFromPayload(
  config: ChartConfig,
  payload: unknown,
  key: string
) {
  if (typeof payload !== "object" || payload === null) {
    return undefined
  }

  const payloadPayload =
    "payload" in payload &&
    typeof payload.payload === "object" &&
    payload.payload !== null
      ? payload.payload
      : undefined

  let configLabelKey: string = key

  if (
    key in payload &&
    typeof payload[key as keyof typeof payload] === "string"
  ) {
    configLabelKey = payload[key as keyof typeof payload] as string
  } else if (
    payloadPayload &&
    key in payloadPayload &&
    typeof payloadPayload[key as keyof typeof payloadPayload] === "string"
  ) {
    configLabelKey = payloadPayload[
      key as keyof typeof payloadPayload
    ] as string
  }

  return configLabelKey in config
    ? config[configLabelKey]
    : config[key as keyof typeof config]
}

export {
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
  ChartLegend,
  ChartLegendContent,
  ChartStyle,
}
EOF

cat <<'EOF' > src/components/ui/checkbox.tsx
"use client"

import * as React from "react"
import * as CheckboxPrimitive from "@radix-ui/react-checkbox"
import { Check } from "lucide-react"

import { cn } from "@/lib/utils"

const Checkbox = React.forwardRef<
  React.ElementRef<typeof CheckboxPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof CheckboxPrimitive.Root>
>(({ className, ...props }, ref) => (
  <CheckboxPrimitive.Root
    ref={ref}
    className={cn(
      "peer h-4 w-4 shrink-0 rounded-sm border border-primary ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 data-[state=checked]:bg-primary data-[state=checked]:text-primary-foreground",
      className
    )}
    {...props}
  >
    <CheckboxPrimitive.Indicator
      className={cn("flex items-center justify-center text-current")}
    >
      <Check className="h-4 w-4" />
    </CheckboxPrimitive.Indicator>
  </CheckboxPrimitive.Root>
))
Checkbox.displayName = CheckboxPrimitive.Root.displayName

export { Checkbox }
EOF

cat <<'EOF' > src/components/ui/dialog.tsx
"use client"

import * as React from "react"
import * as DialogPrimitive from "@radix-ui/react-dialog"
import { X } from "lucide-react"

import { cn } from "@/lib/utils"

const Dialog = DialogPrimitive.Root

const DialogTrigger = DialogPrimitive.Trigger

const DialogPortal = DialogPrimitive.Portal

const DialogClose = DialogPrimitive.Close

const DialogOverlay = React.forwardRef<
  React.ElementRef<typeof DialogPrimitive.Overlay>,
  React.ComponentPropsWithoutRef<typeof DialogPrimitive.Overlay>
>(({ className, ...props }, ref) => (
  <DialogPrimitive.Overlay
    ref={ref}
    className={cn(
      "fixed inset-0 z-50 bg-black/80 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0",
      className
    )}
    {...props}
  />
))
DialogOverlay.displayName = DialogPrimitive.Overlay.displayName

const DialogContent = React.forwardRef<
  React.ElementRef<typeof DialogPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof DialogPrimitive.Content>
>(({ className, children, ...props }, ref) => (
  <DialogPortal>
    <DialogOverlay />
    <DialogPrimitive.Content
      ref={ref}
      className={cn(
        "fixed left-[50%] top-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 border bg-background p-6 shadow-lg duration-200 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%] sm:rounded-lg",
        className
      )}
      {...props}
    >
      {children}
      <DialogPrimitive.Close className="absolute right-4 top-4 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-accent data-[state=open]:text-muted-foreground">
        <X className="h-4 w-4" />
        <span className="sr-only">Close</span>
      </DialogPrimitive.Close>
    </DialogPrimitive.Content>
  </DialogPortal>
))
DialogContent.displayName = DialogPrimitive.Content.displayName

const DialogHeader = ({
  className,
  ...props
}: React.HTMLAttributes<HTMLDivElement>) => (
  <div
    className={cn(
      "flex flex-col space-y-1.5 text-center sm:text-left",
      className
    )}
    {...props}
  />
)
DialogHeader.displayName = "DialogHeader"

const DialogFooter = ({
  className,
  ...props
}: React.HTMLAttributes<HTMLDivElement>) => (
  <div
    className={cn(
      "flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2",
      className
    )}
    {...props}
  />
)
DialogFooter.displayName = "DialogFooter"

const DialogTitle = React.forwardRef<
  React.ElementRef<typeof DialogPrimitive.Title>,
  React.ComponentPropsWithoutRef<typeof DialogPrimitive.Title>
>(({ className, ...props }, ref) => (
  <DialogPrimitive.Title
    ref={ref}
    className={cn(
      "text-lg font-semibold leading-none tracking-tight",
      className
    )}
    {...props}
  />
))
DialogTitle.displayName = DialogPrimitive.Title.displayName

const DialogDescription = React.forwardRef<
  React.ElementRef<typeof DialogPrimitive.Description>,
  React.ComponentPropsWithoutRef<typeof DialogPrimitive.Description>
>(({ className, ...props }, ref) => (
  <DialogPrimitive.Description
    ref={ref}
    className={cn("text-sm text-muted-foreground", className)}
    {...props}
  />
))
DialogDescription.displayName = DialogPrimitive.Description.displayName

export {
  Dialog,
  DialogPortal,
  DialogOverlay,
  DialogClose,
  DialogTrigger,
  DialogContent,
  DialogHeader,
  DialogFooter,
  DialogTitle,
  DialogDescription,
}
EOF

cat <<'EOF' > src/components/ui/dropdown-menu.tsx
"use client"

import * as React from "react"
import * as DropdownMenuPrimitive from "@radix-ui/react-dropdown-menu"
import { Check, ChevronRight, Circle } from "lucide-react"

import { cn } from "@/lib/utils"

const DropdownMenu = DropdownMenuPrimitive.Root

const DropdownMenuTrigger = DropdownMenuPrimitive.Trigger

const DropdownMenuGroup = DropdownMenuPrimitive.Group

const DropdownMenuPortal = DropdownMenuPrimitive.Portal

const DropdownMenuSub = DropdownMenuPrimitive.Sub

const DropdownMenuRadioGroup = DropdownMenuPrimitive.RadioGroup

const DropdownMenuSubTrigger = React.forwardRef<
  React.ElementRef<typeof DropdownMenuPrimitive.SubTrigger>,
  React.ComponentPropsWithoutRef<typeof DropdownMenuPrimitive.SubTrigger> & {
    inset?: boolean
  }
>(({ className, inset, children, ...props }, ref) => (
  <DropdownMenuPrimitive.SubTrigger
    ref={ref}
    className={cn(
      "flex cursor-default gap-2 select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none focus:bg-accent data-[state=open]:bg-accent [&>svg]:pointer-events-none [&>svg]:size-4 [&>svg]:shrink-0",
      inset && "pl-8",
      className
    )}
    {...props}
  >
    {children}
    <ChevronRight className="ml-auto" />
  </DropdownMenuPrimitive.SubTrigger>
))
DropdownMenuSubTrigger.displayName =
  DropdownMenuPrimitive.SubTrigger.displayName

const DropdownMenuSubContent = React.forwardRef<
  React.ElementRef<typeof DropdownMenuPrimitive.SubContent>,
  React.ComponentPropsWithoutRef<typeof DropdownMenuPrimitive.SubContent>
>(({ className, ...props }, ref) => (
  <DropdownMenuPrimitive.SubContent
    ref={ref}
    className={cn(
      "z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-lg data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2",
      className
    )}
    {...props}
  />
))
DropdownMenuSubContent.displayName =
  DropdownMenuPrimitive.SubContent.displayName

const DropdownMenuContent = React.forwardRef<
  React.ElementRef<typeof DropdownMenuPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof DropdownMenuPrimitive.Content>
>(({ className, sideOffset = 4, ...props }, ref) => (
  <DropdownMenuPrimitive.Portal>
    <DropdownMenuPrimitive.Content
      ref={ref}
      sideOffset={sideOffset}
      className={cn(
        "z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2",
        className
      )}
      {...props}
    />
  </DropdownMenuPrimitive.Portal>
))
DropdownMenuContent.displayName = DropdownMenuPrimitive.Content.displayName

const DropdownMenuItem = React.forwardRef<
  React.ElementRef<typeof DropdownMenuPrimitive.Item>,
  React.ComponentPropsWithoutRef<typeof DropdownMenuPrimitive.Item> & {
    inset?: boolean
  }
>(({ className, inset, ...props }, ref) => (
  <DropdownMenuPrimitive.Item
    ref={ref}
    className={cn(
      "relative flex cursor-default select-none items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0",
      inset && "pl-8",
      className
    )}
    {...props}
  />
))
DropdownMenuItem.displayName = DropdownMenuPrimitive.Item.displayName

const DropdownMenuCheckboxItem = React.forwardRef<
  React.ElementRef<typeof DropdownMenuPrimitive.CheckboxItem>,
  React.ComponentPropsWithoutRef<typeof DropdownMenuPrimitive.CheckboxItem>
>(({ className, children, checked, ...props }, ref) => (
  <DropdownMenuPrimitive.CheckboxItem
    ref={ref}
    className={cn(
      "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
      className
    )}
    checked={checked}
    {...props}
  >
    <span className="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      <DropdownMenuPrimitive.ItemIndicator>
        <Check className="h-4 w-4" />
      </DropdownMenuPrimitive.ItemIndicator>
    </span>
    {children}
  </DropdownMenuPrimitive.CheckboxItem>
))
DropdownMenuCheckboxItem.displayName =
  DropdownMenuPrimitive.CheckboxItem.displayName

const DropdownMenuRadioItem = React.forwardRef<
  React.ElementRef<typeof DropdownMenuPrimitive.RadioItem>,
  React.ComponentPropsWithoutRef<typeof DropdownMenuPrimitive.RadioItem>
>(({ className, children, ...props }, ref) => (
  <DropdownMenuPrimitive.RadioItem
    ref={ref}
    className={cn(
      "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none transition-colors focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
      className
    )}
    {...props}
  >
    <span className="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      <DropdownMenuPrimitive.ItemIndicator>
        <Circle className="h-2 w-2 fill-current" />
      </DropdownMenuPrimitive.ItemIndicator>
    </span>
    {children}
  </DropdownMenuPrimitive.RadioItem>
))
DropdownMenuRadioItem.displayName = DropdownMenuPrimitive.RadioItem.displayName

const DropdownMenuLabel = React.forwardRef<
  React.ElementRef<typeof DropdownMenuPrimitive.Label>,
  React.ComponentPropsWithoutRef<typeof DropdownMenuPrimitive.Label> & {
    inset?: boolean
  }
>(({ className, inset, ...props }, ref) => (
  <DropdownMenuPrimitive.Label
    ref={ref}
    className={cn(
      "px-2 py-1.5 text-sm font-semibold",
      inset && "pl-8",
      className
    )}
    {...props}
  />
))
DropdownMenuLabel.displayName = DropdownMenuPrimitive.Label.displayName

const DropdownMenuSeparator = React.forwardRef<
  React.ElementRef<typeof DropdownMenuPrimitive.Separator>,
  React.ComponentPropsWithoutRef<typeof DropdownMenuPrimitive.Separator>
>(({ className, ...props }, ref) => (
  <DropdownMenuPrimitive.Separator
    ref={ref}
    className={cn("-mx-1 my-1 h-px bg-muted", className)}
    {...props}
  />
))
DropdownMenuSeparator.displayName = DropdownMenuPrimitive.Separator.displayName

const DropdownMenuShortcut = ({
  className,
  ...props
}: React.HTMLAttributes<HTMLSpanElement>) => {
  return (
    <span
      className={cn("ml-auto text-xs tracking-widest opacity-60", className)}
      {...props}
    />
  )
}
DropdownMenuShortcut.displayName = "DropdownMenuShortcut"

export {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuCheckboxItem,
  DropdownMenuRadioItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
  DropdownMenuGroup,
  DropdownMenuPortal,
  DropdownMenuSub,
  DropdownMenuSubContent,
  DropdownMenuSubTrigger,
  DropdownMenuRadioGroup,
}
EOF

cat <<'EOF' > src/components/ui/form.tsx
"use client"

import * as React from "react"
import * as LabelPrimitive from "@radix-ui/react-label"
import { Slot } from "@radix-ui/react-slot"
import {
  Controller,
  FormProvider,
  useFormContext,
  type ControllerProps,
  type FieldPath,
  type FieldValues,
} from "react-hook-form"

import { cn } from "@/lib/utils"
import { Label } from "@/components/ui/label"

const Form = FormProvider

type FormFieldContextValue<
  TFieldValues extends FieldValues = FieldValues,
  TName extends FieldPath<TFieldValues> = FieldPath<TFieldValues>
> = {
  name: TName
}

const FormFieldContext = React.createContext<FormFieldContextValue>(
  {} as FormFieldContextValue
)

const FormField = <
  TFieldValues extends FieldValues = FieldValues,
  TName extends FieldPath<TFieldValues> = FieldPath<TFieldValues>
>({
  ...props
}: ControllerProps<TFieldValues, TName>) => {
  return (
    <FormFieldContext.Provider value={{ name: props.name }}>
      <Controller {...props} />
    </FormFieldContext.Provider>
  )
}

const useFormField = () => {
  const fieldContext = React.useContext(FormFieldContext)
  const itemContext = React.useContext(FormItemContext)
  const { getFieldState, formState } = useFormContext()

  const fieldState = getFieldState(fieldContext.name, formState)

  if (!fieldContext) {
    throw new Error("useFormField should be used within <FormField>")
  }

  const { id } = itemContext

  return {
    id,
    name: fieldContext.name,
    formItemId: `${id}-form-item`,
    formDescriptionId: `${id}-form-item-description`,
    formMessageId: `${id}-form-item-message`,
    ...fieldState,
  }
}

type FormItemContextValue = {
  id: string
}

const FormItemContext = React.createContext<FormItemContextValue>(
  {} as FormItemContextValue
)

const FormItem = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => {
  const id = React.useId()

  return (
    <FormItemContext.Provider value={{ id }}>
      <div ref={ref} className={cn("space-y-2", className)} {...props} />
    </FormItemContext.Provider>
  )
})
FormItem.displayName = "FormItem"

const FormLabel = React.forwardRef<
  React.ElementRef<typeof LabelPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof LabelPrimitive.Root>
>(({ className, ...props }, ref) => {
  const { error, formItemId } = useFormField()

  return (
    <Label
      ref={ref}
      className={cn(error && "text-destructive", className)}
      htmlFor={formItemId}
      {...props}
    />
  )
})
FormLabel.displayName = "FormLabel"

const FormControl = React.forwardRef<
  React.ElementRef<typeof Slot>,
  React.ComponentPropsWithoutRef<typeof Slot>
>(({ ...props }, ref) => {
  const { error, formItemId, formDescriptionId, formMessageId } = useFormField()

  return (
    <Slot
      ref={ref}
      id={formItemId}
      aria-describedby={
        !error
          ? `${formDescriptionId}`
          : `${formDescriptionId} ${formMessageId}`
      }
      aria-invalid={!!error}
      {...props}
    />
  )
})
FormControl.displayName = "FormControl"

const FormDescription = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLParagraphElement>
>(({ className, ...props }, ref) => {
  const { formDescriptionId } = useFormField()

  return (
    <p
      ref={ref}
      id={formDescriptionId}
      className={cn("text-sm text-muted-foreground", className)}
      {...props}
    />
  )
})
FormDescription.displayName = "FormDescription"

const FormMessage = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLParagraphElement>
>(({ className, children, ...props }, ref) => {
  const { error, formMessageId } = useFormField()
  const body = error ? String(error?.message ?? "") : children

  if (!body) {
    return null
  }

  return (
    <p
      ref={ref}
      id={formMessageId}
      className={cn("text-sm font-medium text-destructive", className)}
      {...props}
    >
      {body}
    </p>
  )
})
FormMessage.displayName = "FormMessage"

export {
  useFormField,
  Form,
  FormItem,
  FormLabel,
  FormControl,
  FormDescription,
  FormMessage,
  FormField,
}
EOF

cat <<'EOF' > src/components/ui/input.tsx
import * as React from "react"

import { cn } from "@/lib/utils"

const Input = React.forwardRef<HTMLInputElement, React.ComponentProps<"input">>(
  ({ className, type, ...props }, ref) => {
    return (
      <input
        type={type}
        className={cn(
          "flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-base ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium file:text-foreground placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 md:text-sm",
          className
        )}
        ref={ref}
        {...props}
      />
    )
  }
)
Input.displayName = "Input"

export { Input }
EOF

cat <<'EOF' > src/components/ui/label.tsx
"use client"

import * as React from "react"
import * as LabelPrimitive from "@radix-ui/react-label"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const labelVariants = cva(
  "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
)

const Label = React.forwardRef<
  React.ElementRef<typeof LabelPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof LabelPrimitive.Root> &
    VariantProps<typeof labelVariants>
>(({ className, ...props }, ref) => (
  <LabelPrimitive.Root
    ref={ref}
    className={cn(labelVariants(), className)}
    {...props}
  />
))
Label.displayName = LabelPrimitive.Root.displayName

export { Label }
EOF

cat <<'EOF' > src/components/ui/menubar.tsx
"use client"

import * as React from "react"
import * as MenubarPrimitive from "@radix-ui/react-menubar"
import { Check, ChevronRight, Circle } from "lucide-react"

import { cn } from "@/lib/utils"

function MenubarMenu({
  ...props
}: React.ComponentProps<typeof MenubarPrimitive.Menu>) {
  return <MenubarPrimitive.Menu {...props} />
}

function MenubarGroup({
  ...props
}: React.ComponentProps<typeof MenubarPrimitive.Group>) {
  return <MenubarPrimitive.Group {...props} />
}

function MenubarPortal({
  ...props
}: React.ComponentProps<typeof MenubarPrimitive.Portal>) {
  return <MenubarPrimitive.Portal {...props} />
}

function MenubarRadioGroup({
  ...props
}: React.ComponentProps<typeof MenubarPrimitive.RadioGroup>) {
  return <MenubarPrimitive.RadioGroup {...props} />
}

function MenubarSub({
  ...props
}: React.ComponentProps<typeof MenubarPrimitive.Sub>) {
  return <MenubarPrimitive.Sub data-slot="menubar-sub" {...props} />
}

const Menubar = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.Root>
>(({ className, ...props }, ref) => (
  <MenubarPrimitive.Root
    ref={ref}
    className={cn(
      "flex h-10 items-center space-x-1 rounded-md border bg-background p-1",
      className
    )}
    {...props}
  />
))
Menubar.displayName = MenubarPrimitive.Root.displayName

const MenubarTrigger = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.Trigger>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.Trigger>
>(({ className, ...props }, ref) => (
  <MenubarPrimitive.Trigger
    ref={ref}
    className={cn(
      "flex cursor-default select-none items-center rounded-sm px-3 py-1.5 text-sm font-medium outline-none focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground",
      className
    )}
    {...props}
  />
))
MenubarTrigger.displayName = MenubarPrimitive.Trigger.displayName

const MenubarSubTrigger = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.SubTrigger>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.SubTrigger> & {
    inset?: boolean
  }
>(({ className, inset, children, ...props }, ref) => (
  <MenubarPrimitive.SubTrigger
    ref={ref}
    className={cn(
      "flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground",
      inset && "pl-8",
      className
    )}
    {...props}
  >
    {children}
    <ChevronRight className="ml-auto h-4 w-4" />
  </MenubarPrimitive.SubTrigger>
))
MenubarSubTrigger.displayName = MenubarPrimitive.SubTrigger.displayName

const MenubarSubContent = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.SubContent>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.SubContent>
>(({ className, ...props }, ref) => (
  <MenubarPrimitive.SubContent
    ref={ref}
    className={cn(
      "z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2",
      className
    )}
    {...props}
  />
))
MenubarSubContent.displayName = MenubarPrimitive.SubContent.displayName

const MenubarContent = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.Content>
>(
  (
    { className, align = "start", alignOffset = -4, sideOffset = 8, ...props },
    ref
  ) => (
    <MenubarPrimitive.Portal>
      <MenubarPrimitive.Content
        ref={ref}
        align={align}
        alignOffset={alignOffset}
        sideOffset={sideOffset}
        className={cn(
          "z-50 min-w-[12rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md data-[state=open]:animate-in data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2",
          className
        )}
        {...props}
      />
    </MenubarPrimitive.Portal>
  )
)
MenubarContent.displayName = MenubarPrimitive.Content.displayName

const MenubarItem = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.Item>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.Item> & {
    inset?: boolean
  }
>(({ className, inset, ...props }, ref) => (
  <MenubarPrimitive.Item
    ref={ref}
    className={cn(
      "relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
      inset && "pl-8",
      className
    )}
    {...props}
  />
))
MenubarItem.displayName = MenubarPrimitive.Item.displayName

const MenubarCheckboxItem = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.CheckboxItem>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.CheckboxItem>
>(({ className, children, checked, ...props }, ref) => (
  <MenubarPrimitive.CheckboxItem
    ref={ref}
    className={cn(
      "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
      className
    )}
    checked={checked}
    {...props}
  >
    <span className="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      <MenubarPrimitive.ItemIndicator>
        <Check className="h-4 w-4" />
      </MenubarPrimitive.ItemIndicator>
    </span>
    {children}
  </MenubarPrimitive.CheckboxItem>
))
MenubarCheckboxItem.displayName = MenubarPrimitive.CheckboxItem.displayName

const MenubarRadioItem = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.RadioItem>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.RadioItem>
>(({ className, children, ...props }, ref) => (
  <MenubarPrimitive.RadioItem
    ref={ref}
    className={cn(
      "relative flex cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
      className
    )}
    {...props}
  >
    <span className="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      <MenubarPrimitive.ItemIndicator>
        <Circle className="h-2 w-2 fill-current" />
      </MenubarPrimitive.ItemIndicator>
    </span>
    {children}
  </MenubarPrimitive.RadioItem>
))
MenubarRadioItem.displayName = MenubarPrimitive.RadioItem.displayName

const MenubarLabel = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.Label>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.Label> & {
    inset?: boolean
  }
>(({ className, inset, ...props }, ref) => (
  <MenubarPrimitive.Label
    ref={ref}
    className={cn(
      "px-2 py-1.5 text-sm font-semibold",
      inset && "pl-8",
      className
    )}
    {...props}
  />
))
MenubarLabel.displayName = MenubarPrimitive.Label.displayName

const MenubarSeparator = React.forwardRef<
  React.ElementRef<typeof MenubarPrimitive.Separator>,
  React.ComponentPropsWithoutRef<typeof MenubarPrimitive.Separator>
>(({ className, ...props }, ref) => (
  <MenubarPrimitive.Separator
    ref={ref}
    className={cn("-mx-1 my-1 h-px bg-muted", className)}
    {...props}
  />
))
MenubarSeparator.displayName = MenubarPrimitive.Separator.displayName

const MenubarShortcut = ({
  className,
  ...props
}: React.HTMLAttributes<HTMLSpanElement>) => {
  return (
    <span
      className={cn(
        "ml-auto text-xs tracking-widest text-muted-foreground",
        className
      )}
      {...props}
    />
  )
}
MenubarShortcut.displayname = "MenubarShortcut"

export {
  Menubar,
  MenubarMenu,
  MenubarTrigger,
  MenubarContent,
  MenubarItem,
  MenubarSeparator,
  MenubarLabel,
  MenubarCheckboxItem,
  MenubarRadioGroup,
  MenubarRadioItem,
  MenubarPortal,
  MenubarSubContent,
  MenubarSubTrigger,
  MenubarGroup,
  MenubarSub,
  MenubarShortcut,
}
EOF

cat <<'EOF' > src/components/ui/popover.tsx
"use client"

import * as React from "react"
import * as PopoverPrimitive from "@radix-ui/react-popover"

import { cn } from "@/lib/utils"

const Popover = PopoverPrimitive.Root

const PopoverTrigger = PopoverPrimitive.Trigger

const PopoverContent = React.forwardRef<
  React.ElementRef<typeof PopoverPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof PopoverPrimitive.Content>
>(({ className, align = "center", sideOffset = 4, ...props }, ref) => (
  <PopoverPrimitive.Portal>
    <PopoverPrimitive.Content
      ref={ref}
      align={align}
      sideOffset={sideOffset}
      className={cn(
        "z-50 w-72 rounded-md border bg-popover p-4 text-popover-foreground shadow-md outline-none data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2",
        className
      )}
      {...props}
    />
  </PopoverPrimitive.Portal>
))
PopoverContent.displayName = PopoverPrimitive.Content.displayName

export { Popover, PopoverTrigger, PopoverContent }
EOF

cat <<'EOF' > src/components/ui/progress.tsx
"use client"

import * as React from "react"
import * as ProgressPrimitive from "@radix-ui/react-progress"

import { cn } from "@/lib/utils"

const Progress = React.forwardRef<
  React.ElementRef<typeof ProgressPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof ProgressPrimitive.Root>
>(({ className, value, ...props }, ref) => (
  <ProgressPrimitive.Root
    ref={ref}
    className={cn(
      "relative h-4 w-full overflow-hidden rounded-full bg-secondary",
      className
    )}
    {...props}
  >
    <ProgressPrimitive.Indicator
      className="h-full w-full flex-1 bg-primary transition-all"
      style={{ transform: `translateX(-${100 - (value || 0)}%)` }}
    />
  </ProgressPrimitive.Root>
))
Progress.displayName = ProgressPrimitive.Root.displayName

export { Progress }
EOF

cat <<'EOF' > src/components/ui/radio-group.tsx
"use client"

import * as React from "react"
import * as RadioGroupPrimitive from "@radix-ui/react-radio-group"
import { Circle } from "lucide-react"

import { cn } from "@/lib/utils"

const RadioGroup = React.forwardRef<
  React.ElementRef<typeof RadioGroupPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof RadioGroupPrimitive.Root>
>(({ className, ...props }, ref) => {
  return (
    <RadioGroupPrimitive.Root
      className={cn("grid gap-2", className)}
      {...props}
      ref={ref}
    />
  )
})
RadioGroup.displayName = RadioGroupPrimitive.Root.displayName

const RadioGroupItem = React.forwardRef<
  React.ElementRef<typeof RadioGroupPrimitive.Item>,
  React.ComponentPropsWithoutRef<typeof RadioGroupPrimitive.Item>
>(({ className, ...props }, ref) => {
  return (
    <RadioGroupPrimitive.Item
      ref={ref}
      className={cn(
        "aspect-square h-4 w-4 rounded-full border border-primary text-primary ring-offset-background focus:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
        className
      )}
      {...props}
    >
      <RadioGroupPrimitive.Indicator className="flex items-center justify-center">
        <Circle className="h-2.5 w-2.5 fill-current text-current" />
      </RadioGroupPrimitive.Indicator>
    </RadioGroupPrimitive.Item>
  )
})
RadioGroupItem.displayName = RadioGroupPrimitive.Item.displayName

export { RadioGroup, RadioGroupItem }
EOF

cat <<'EOF' > src/components/ui/scroll-area.tsx
"use client"

import * as React from "react"
import * as ScrollAreaPrimitive from "@radix-ui/react-scroll-area"

import { cn } from "@/lib/utils"

const ScrollArea = React.forwardRef<
  React.ElementRef<typeof ScrollAreaPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof ScrollAreaPrimitive.Root>
>(({ className, children, ...props }, ref) => (
  <ScrollAreaPrimitive.Root
    ref={ref}
    className={cn("relative overflow-hidden", className)}
    {...props}
  >
    <ScrollAreaPrimitive.Viewport className="h-full w-full rounded-[inherit]">
      {children}
    </ScrollAreaPrimitive.Viewport>
    <ScrollBar />
    <ScrollAreaPrimitive.Corner />
  </ScrollAreaPrimitive.Root>
))
ScrollArea.displayName = ScrollAreaPrimitive.Root.displayName

const ScrollBar = React.forwardRef<
  React.ElementRef<typeof ScrollAreaPrimitive.ScrollAreaScrollbar>,
  React.ComponentPropsWithoutRef<typeof ScrollAreaPrimitive.ScrollAreaScrollbar>
>(({ className, orientation = "vertical", ...props }, ref) => (
  <ScrollAreaPrimitive.ScrollAreaScrollbar
    ref={ref}
    orientation={orientation}
    className={cn(
      "flex touch-none select-none transition-colors",
      orientation === "vertical" &&
        "h-full w-2.5 border-l border-l-transparent p-[1px]",
      orientation === "horizontal" &&
        "h-2.5 flex-col border-t border-t-transparent p-[1px]",
      className
    )}
    {...props}
  >
    <ScrollAreaPrimitive.ScrollAreaThumb className="relative flex-1 rounded-full bg-border" />
  </ScrollAreaPrimitive.ScrollAreaScrollbar>
))
ScrollBar.displayName = ScrollAreaPrimitive.ScrollAreaScrollbar.displayName

export { ScrollArea, ScrollBar }
EOF

cat <<'EOF' > src/components/ui/select.tsx
"use client"

import * as React from "react"
import * as SelectPrimitive from "@radix-ui/react-select"
import { Check, ChevronDown, ChevronUp } from "lucide-react"

import { cn } from "@/lib/utils"

const Select = SelectPrimitive.Root

const SelectGroup = SelectPrimitive.Group

const SelectValue = SelectPrimitive.Value

const SelectTrigger = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Trigger>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Trigger>
>(({ className, children, ...props }, ref) => (
  <SelectPrimitive.Trigger
    ref={ref}
    className={cn(
      "flex h-10 w-full items-center justify-between rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 [&>span]:line-clamp-1",
      className
    )}
    {...props}
  >
    {children}
    <SelectPrimitive.Icon asChild>
      <ChevronDown className="h-4 w-4 opacity-50" />
    </SelectPrimitive.Icon>
  </SelectPrimitive.Trigger>
))
SelectTrigger.displayName = SelectPrimitive.Trigger.displayName

const SelectScrollUpButton = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.ScrollUpButton>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.ScrollUpButton>
>(({ className, ...props }, ref) => (
  <SelectPrimitive.ScrollUpButton
    ref={ref}
    className={cn(
      "flex cursor-default items-center justify-center py-1",
      className
    )}
    {...props}
  >
    <ChevronUp className="h-4 w-4" />
  </SelectPrimitive.ScrollUpButton>
))
SelectScrollUpButton.displayName = SelectPrimitive.ScrollUpButton.displayName

const SelectScrollDownButton = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.ScrollDownButton>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.ScrollDownButton>
>(({ className, ...props }, ref) => (
  <SelectPrimitive.ScrollDownButton
    ref={ref}
    className={cn(
      "flex cursor-default items-center justify-center py-1",
      className
    )}
    {...props}
  >
    <ChevronDown className="h-4 w-4" />
  </SelectPrimitive.ScrollDownButton>
))
SelectScrollDownButton.displayName =
  SelectPrimitive.ScrollDownButton.displayName

const SelectContent = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Content>
>(({ className, children, position = "popper", ...props }, ref) => (
  <SelectPrimitive.Portal>
    <SelectPrimitive.Content
      ref={ref}
      className={cn(
        "relative z-50 max-h-96 min-w-[8rem] overflow-hidden rounded-md border bg-popover text-popover-foreground shadow-md data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2",
        position === "popper" &&
          "data-[side=bottom]:translate-y-1 data-[side=left]:-translate-x-1 data-[side=right]:translate-x-1 data-[side=top]:-translate-y-1",
        className
      )}
      position={position}
      {...props}
    >
      <SelectScrollUpButton />
      <SelectPrimitive.Viewport
        className={cn(
          "p-1",
          position === "popper" &&
            "h-[var(--radix-select-trigger-height)] w-full min-w-[var(--radix-select-trigger-width)]"
        )}
      >
        {children}
      </SelectPrimitive.Viewport>
      <SelectScrollDownButton />
    </SelectPrimitive.Content>
  </SelectPrimitive.Portal>
))
SelectContent.displayName = SelectPrimitive.Content.displayName

const SelectLabel = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Label>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Label>
>(({ className, ...props }, ref) => (
  <SelectPrimitive.Label
    ref={ref}
    className={cn("py-1.5 pl-8 pr-2 text-sm font-semibold", className)}
    {...props}
  />
))
SelectLabel.displayName = SelectPrimitive.Label.displayName

const SelectItem = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Item>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Item>
>(({ className, children, ...props }, ref) => (
  <SelectPrimitive.Item
    ref={ref}
    className={cn(
      "relative flex w-full cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none focus:bg-accent focus:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50",
      className
    )}
    {...props}
  >
    <span className="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      <SelectPrimitive.ItemIndicator>
        <Check className="h-4 w-4" />
      </SelectPrimitive.ItemIndicator>
    </span>

    <SelectPrimitive.ItemText>{children}</SelectPrimitive.ItemText>
  </SelectPrimitive.Item>
))
SelectItem.displayName = SelectPrimitive.Item.displayName

const SelectSeparator = React.forwardRef<
  React.ElementRef<typeof SelectPrimitive.Separator>,
  React.ComponentPropsWithoutRef<typeof SelectPrimitive.Separator>
>(({ className, ...props }, ref) => (
  <SelectPrimitive.Separator
    ref={ref}
    className={cn("-mx-1 my-1 h-px bg-muted", className)}
    {...props}
  />
))
SelectSeparator.displayName = SelectPrimitive.Separator.displayName

export {
  Select,
  SelectGroup,
  SelectValue,
  SelectTrigger,
  SelectContent,
  SelectLabel,
  SelectItem,
  SelectSeparator,
  SelectScrollUpButton,
  SelectScrollDownButton,
}
EOF

cat <<'EOF' > src/components/ui/separator.tsx
"use client"

import * as React from "react"
import * as SeparatorPrimitive from "@radix-ui/react-separator"

import { cn } from "@/lib/utils"

const Separator = React.forwardRef<
  React.ElementRef<typeof SeparatorPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof SeparatorPrimitive.Root>
>(
  (
    { className, orientation = "horizontal", decorative = true, ...props },
    ref
  ) => (
    <SeparatorPrimitive.Root
      ref={ref}
      decorative={decorative}
      orientation={orientation}
      className={cn(
        "shrink-0 bg-border",
        orientation === "horizontal" ? "h-[1px] w-full" : "h-full w-[1px]",
        className
      )}
      {...props}
    />
  )
)
Separator.displayName = SeparatorPrimitive.Root.displayName

export { Separator }
EOF

cat <<'EOF' > src/components/ui/sheet.tsx
"use client"

import * as React from "react"
import * as SheetPrimitive from "@radix-ui/react-dialog"
import { cva, type VariantProps } from "class-variance-authority"
import { X } from "lucide-react"

import { cn } from "@/lib/utils"

const Sheet = SheetPrimitive.Root

const SheetTrigger = SheetPrimitive.Trigger

const SheetClose = SheetPrimitive.Close

const SheetPortal = SheetPrimitive.Portal

const SheetOverlay = React.forwardRef<
  React.ElementRef<typeof SheetPrimitive.Overlay>,
  React.ComponentPropsWithoutRef<typeof SheetPrimitive.Overlay>
>(({ className, ...props }, ref) => (
  <SheetPrimitive.Overlay
    className={cn(
      "fixed inset-0 z-50 bg-black/80  data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0",
      className
    )}
    {...props}
    ref={ref}
  />
))
SheetOverlay.displayName = SheetPrimitive.Overlay.displayName

const sheetVariants = cva(
  "fixed z-50 gap-4 bg-background p-6 shadow-lg transition ease-in-out data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:duration-300 data-[state=open]:duration-500",
  {
    variants: {
      side: {
        top: "inset-x-0 top-0 border-b data-[state=closed]:slide-out-to-top data-[state=open]:slide-in-from-top",
        bottom:
          "inset-x-0 bottom-0 border-t data-[state=closed]:slide-out-to-bottom data-[state=open]:slide-in-from-bottom",
        left: "inset-y-0 left-0 h-full w-3/4 border-r data-[state=closed]:slide-out-to-left data-[state=open]:slide-in-from-left sm:max-w-sm",
        right:
          "inset-y-0 right-0 h-full w-3/4  border-l data-[state=closed]:slide-out-to-right data-[state=open]:slide-in-from-right sm:max-w-sm",
      },
    },
    defaultVariants: {
      side: "right",
    },
  }
)

interface SheetContentProps
  extends React.ComponentPropsWithoutRef<typeof SheetPrimitive.Content>,
    VariantProps<typeof sheetVariants> {}

const SheetContent = React.forwardRef<
  React.ElementRef<typeof SheetPrimitive.Content>,
  SheetContentProps
>(({ side = "right", className, children, ...props }, ref) => (
  <SheetPortal>
    <SheetOverlay />
    <SheetPrimitive.Content
      ref={ref}
      className={cn(sheetVariants({ side }), className)}
      {...props}
    >
      {children}
      <SheetPrimitive.Close className="absolute right-4 top-4 rounded-sm opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none data-[state=open]:bg-secondary">
        <X className="h-4 w-4" />
        <span className="sr-only">Close</span>
      </SheetPrimitive.Close>
    </SheetPrimitive.Content>
  </SheetPortal>
))
SheetContent.displayName = SheetPrimitive.Content.displayName

const SheetHeader = ({
  className,
  ...props
}: React.HTMLAttributes<HTMLDivElement>) => (
  <div
    className={cn(
      "flex flex-col space-y-2 text-center sm:text-left",
      className
    )}
    {...props}
  />
)
SheetHeader.displayName = "SheetHeader"

const SheetFooter = ({
  className,
  ...props
}: React.HTMLAttributes<HTMLDivElement>) => (
  <div
    className={cn(
      "flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2",
      className
    )}
    {...props}
  />
)
SheetFooter.displayName = "SheetFooter"

const SheetTitle = React.forwardRef<
  React.ElementRef<typeof SheetPrimitive.Title>,
  React.ComponentPropsWithoutRef<typeof SheetPrimitive.Title>
>(({ className, ...props }, ref) => (
  <SheetPrimitive.Title
    ref={ref}
    className={cn("text-lg font-semibold text-foreground", className)}
    {...props}
  />
))
SheetTitle.displayName = SheetPrimitive.Title.displayName

const SheetDescription = React.forwardRef<
  React.ElementRef<typeof SheetPrimitive.Description>,
  React.ComponentPropsWithoutRef<typeof SheetPrimitive.Description>
>(({ className, ...props }, ref) => (
  <SheetPrimitive.Description
    ref={ref}
    className={cn("text-sm text-muted-foreground", className)}
    {...props}
  />
))
SheetDescription.displayName = SheetPrimitive.Description.displayName

export {
  Sheet,
  SheetPortal,
  SheetOverlay,
  SheetTrigger,
  SheetClose,
  SheetContent,
  SheetHeader,
  SheetFooter,
  SheetTitle,
  SheetDescription,
}
EOF

cat <<'EOF' > src/components/ui/sidebar.tsx
"use client"

import * as React from "react"
import { Slot } from "@radix-ui/react-slot"
import { VariantProps, cva } from "class-variance-authority"
import { PanelLeft } from "lucide-react"

import { useIsMobile } from "@/hooks/use-mobile"
import { cn } from "@/lib/utils"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Separator } from "@/components/ui/separator"
import { Sheet, SheetContent, SheetTitle } from "@/components/ui/sheet"
import { Skeleton } from "@/components/ui/skeleton"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip"

const SIDEBAR_COOKIE_NAME = "sidebar_state"
const SIDEBAR_COOKIE_MAX_AGE = 60 * 60 * 24 * 7
const SIDEBAR_WIDTH = "16rem"
const SIDEBAR_WIDTH_MOBILE = "18rem"
const SIDEBAR_WIDTH_ICON = "3rem"
const SIDEBAR_KEYBOARD_SHORTCUT = "b"

type SidebarContext = {
  state: "expanded" | "collapsed"
  open: boolean
  setOpen: (open: boolean) => void
  openMobile: boolean
  setOpenMobile: (open: boolean) => void
  isMobile: boolean
  toggleSidebar: () => void
}

const SidebarContext = React.createContext<SidebarContext | null>(null)

function useSidebar() {
  const context = React.useContext(SidebarContext)
  if (!context) {
    throw new Error("useSidebar must be used within a SidebarProvider.")
  }

  return context
}

const SidebarProvider = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div"> & {
    defaultOpen?: boolean
    open?: boolean
    onOpenChange?: (open: boolean) => void
  }
>(
  (
    {
      defaultOpen = true,
      open: openProp,
      onOpenChange: setOpenProp,
      className,
      style,
      children,
      ...props
    },
    ref
  ) => {
    const isMobile = useIsMobile()
    const [openMobile, setOpenMobile] = React.useState(false)

    // This is the internal state of the sidebar.
    // We use openProp and setOpenProp for control from outside the component.
    const [_open, _setOpen] = React.useState(defaultOpen)
    const open = openProp ?? _open
    const setOpen = React.useCallback(
      (value: boolean | ((value: boolean) => boolean)) => {
        const openState = typeof value === "function" ? value(open) : value
        if (setOpenProp) {
          setOpenProp(openState)
        } else {
          _setOpen(openState)
        }

        // This sets the cookie to keep the sidebar state.
        document.cookie = `${SIDEBAR_COOKIE_NAME}=${openState}; path=/; max-age=${SIDEBAR_COOKIE_MAX_AGE}`
      },
      [setOpenProp, open]
    )

    // Helper to toggle the sidebar.
    const toggleSidebar = React.useCallback(() => {
      return isMobile
        ? setOpenMobile((open) => !open)
        : setOpen((open) => !open)
    }, [isMobile, setOpen, setOpenMobile])

    // Adds a keyboard shortcut to toggle the sidebar.
    React.useEffect(() => {
      const handleKeyDown = (event: KeyboardEvent) => {
        if (
          event.key === SIDEBAR_KEYBOARD_SHORTCUT &&
          (event.metaKey || event.ctrlKey)
        ) {
          event.preventDefault()
          toggleSidebar()
        }
      }

      window.addEventListener("keydown", handleKeyDown)
      return () => window.removeEventListener("keydown", handleKeyDown)
    }, [toggleSidebar])

    // We add a state so that we can do data-state="expanded" or "collapsed".
    // This makes it easier to style the sidebar with Tailwind classes.
    const state = open ? "expanded" : "collapsed"

    const contextValue = React.useMemo<SidebarContext>(
      () => ({
        state,
        open,
        setOpen,
        isMobile,
        openMobile,
        setOpenMobile,
        toggleSidebar,
      }),
      [state, open, setOpen, isMobile, openMobile, setOpenMobile, toggleSidebar]
    )

    return (
      <SidebarContext.Provider value={contextValue}>
        <TooltipProvider delayDuration={0}>
          <div
            style={
              {
                "--sidebar-width": SIDEBAR_WIDTH,
                "--sidebar-width-icon": SIDEBAR_WIDTH_ICON,
                ...style,
              } as React.CSSProperties
            }
            className={cn(
              "group/sidebar-wrapper flex min-h-svh w-full has-[[data-variant=inset]]:bg-sidebar",
              className
            )}
            ref={ref}
            {...props}
          >
            {children}
          </div>
        </TooltipProvider>
      </SidebarContext.Provider>
    )
  }
)
SidebarProvider.displayName = "SidebarProvider"

const Sidebar = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div"> & {
    side?: "left" | "right"
    variant?: "sidebar" | "floating" | "inset"
    collapsible?: "offcanvas" | "icon" | "none"
  }
>(
  (
    {
      side = "left",
      variant = "sidebar",
      collapsible = "offcanvas",
      className,
      children,
      ...props
    },
    ref
  ) => {
    const { isMobile, state, openMobile, setOpenMobile } = useSidebar()

    if (collapsible === "none") {
      return (
        <div
          className={cn(
            "flex h-full w-[--sidebar-width] flex-col bg-sidebar text-sidebar-foreground",
            className
          )}
          ref={ref}
          {...props}
        >
          {children}
        </div>
      )
    }

    if (isMobile) {
      return (
        <Sheet open={openMobile} onOpenChange={setOpenMobile} {...props}>
          <SheetContent
            data-sidebar="sidebar"
            data-mobile="true"
            className="w-[--sidebar-width] bg-sidebar p-0 text-sidebar-foreground [&>button]:hidden"
            style={
              {
                "--sidebar-width": SIDEBAR_WIDTH_MOBILE,
              } as React.CSSProperties
            }
            side={side}
          >
            <SheetTitle className="sr-only">Sidebar Menu</SheetTitle>
            <div className="flex h-full w-full flex-col">{children}</div>
          </SheetContent>
        </Sheet>
      )
    }

    return (
      <div
        ref={ref}
        className="group peer hidden md:block text-sidebar-foreground"
        data-state={state}
        data-collapsible={state === "collapsed" ? collapsible : ""}
        data-variant={variant}
        data-side={side}
      >
        {/* This is what handles the sidebar gap on desktop */}
        <div
          className={cn(
            "duration-200 relative h-svh w-[--sidebar-width] bg-transparent transition-[width] ease-linear",
            "group-data-[collapsible=offcanvas]:w-0",
            "group-data-[side=right]:rotate-180",
            variant === "floating" || variant === "inset"
              ? "group-data-[collapsible=icon]:w-[calc(var(--sidebar-width-icon)_+_theme(spacing.4))]"
              : "group-data-[collapsible=icon]:w-[--sidebar-width-icon]"
          )}
        />
        <div
          className={cn(
            "duration-200 fixed inset-y-0 z-10 hidden h-svh w-[--sidebar-width] transition-[left,right,width] ease-linear md:flex",
            side === "left"
              ? "left-0 group-data-[collapsible=offcanvas]:left-[calc(var(--sidebar-width)*-1)]"
              : "right-0 group-data-[collapsible=offcanvas]:right-[calc(var(--sidebar-width)*-1)]",
            // Adjust the padding for floating and inset variants.
            variant === "floating" || variant === "inset"
              ? "p-2 group-data-[collapsible=icon]:w-[calc(var(--sidebar-width-icon)_+_theme(spacing.4)_+2px)]"
              : "group-data-[collapsible=icon]:w-[--sidebar-width-icon] group-data-[side=left]:border-r group-data-[side=right]:border-l",
            className
          )}
          {...props}
        >
          <div
            data-sidebar="sidebar"
            className="flex h-full w-full flex-col bg-sidebar group-data-[variant=floating]:rounded-lg group-data-[variant=floating]:border group-data-[variant=floating]:border-sidebar-border group-data-[variant=floating]:shadow"
          >
            {children}
          </div>
        </div>
      </div>
    )
  }
)
Sidebar.displayName = "Sidebar"

const SidebarTrigger = React.forwardRef<
  React.ElementRef<typeof Button>,
  React.ComponentProps<typeof Button>
>(({ className, onClick, ...props }, ref) => {
  const { toggleSidebar } = useSidebar()

  return (
    <Button
      ref={ref}
      data-sidebar="trigger"
      variant="ghost"
      size="icon"
      className={cn("h-7 w-7", className)}
      onClick={(event) => {
        onClick?.(event)
        toggleSidebar()
      }}
      {...props}
    >
      <PanelLeft />
      <span className="sr-only">Toggle Sidebar</span>
    </Button>
  )
})
SidebarTrigger.displayName = "SidebarTrigger"

const SidebarRail = React.forwardRef<
  HTMLButtonElement,
  React.ComponentProps<"button">
>(({ className, ...props }, ref) => {
  const { toggleSidebar } = useSidebar()

  return (
    <button
      ref={ref}
      data-sidebar="rail"
      aria-label="Toggle Sidebar"
      tabIndex={-1}
      onClick={toggleSidebar}
      title="Toggle Sidebar"
      className={cn(
        "absolute inset-y-0 z-20 hidden w-4 -translate-x-1/2 transition-all ease-linear after:absolute after:inset-y-0 after:left-1/2 after:w-[2px] hover:after:bg-sidebar-border group-data-[side=left]:-right-4 group-data-[side=right]:left-0 sm:flex",
        "[[data-side=left]_&]:cursor-w-resize [[data-side=right]_&]:cursor-e-resize",
        "[[data-side=left][data-state=collapsed]_&]:cursor-e-resize [[data-side=right][data-state=collapsed]_&]:cursor-w-resize",
        "group-data-[collapsible=offcanvas]:translate-x-0 group-data-[collapsible=offcanvas]:after:left-full group-data-[collapsible=offcanvas]:hover:bg-sidebar",
        "[[data-side=left][data-collapsible=offcanvas]_&]:-right-2",
        "[[data-side=right][data-collapsible=offcanvas]_&]:-left-2",
        className
      )}
      {...props}
    />
  )
})
SidebarRail.displayName = "SidebarRail"

const SidebarInset = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"main">
>(({ className, ...props }, ref) => {
  return (
    <main
      ref={ref}
      className={cn(
        "relative flex min-h-svh flex-1 flex-col bg-background",
        "peer-data-[variant=inset]:min-h-[calc(100svh-theme(spacing.4))] md:peer-data-[variant=inset]:m-2 md:peer-data-[state=collapsed]:peer-data-[variant=inset]:ml-2 md:peer-data-[variant=inset]:ml-0 md:peer-data-[variant=inset]:rounded-xl md:peer-data-[variant=inset]:shadow",
        className
      )}
      {...props}
    />
  )
})
SidebarInset.displayName = "SidebarInset"

const SidebarInput = React.forwardRef<
  React.ElementRef<typeof Input>,
  React.ComponentProps<typeof Input>
>(({ className, ...props }, ref) => {
  return (
    <Input
      ref={ref}
      data-sidebar="input"
      className={cn(
        "h-8 w-full bg-background shadow-none focus-visible:ring-2 focus-visible:ring-sidebar-ring",
        className
      )}
      {...props}
    />
  )
})
SidebarInput.displayName = "SidebarInput"

const SidebarHeader = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div">
>(({ className, ...props }, ref) => {
  return (
    <div
      ref={ref}
      data-sidebar="header"
      className={cn("flex flex-col gap-2 p-2", className)}
      {...props}
    />
  )
})
SidebarHeader.displayName = "SidebarHeader"

const SidebarFooter = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div">
>(({ className, ...props }, ref) => {
  return (
    <div
      ref={ref}
      data-sidebar="footer"
      className={cn("flex flex-col gap-2 p-2", className)}
      {...props}
    />
  )
})
SidebarFooter.displayName = "SidebarFooter"

const SidebarSeparator = React.forwardRef<
  React.ElementRef<typeof Separator>,
  React.ComponentProps<typeof Separator>
>(({ className, ...props }, ref) => {
  return (
    <Separator
      ref={ref}
      data-sidebar="separator"
      className={cn("mx-2 w-auto bg-sidebar-border", className)}
      {...props}
    />
  )
})
SidebarSeparator.displayName = "SidebarSeparator"

const SidebarContent = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div">
>(({ className, ...props }, ref) => {
  return (
    <div
      ref={ref}
      data-sidebar="content"
      className={cn(
        "flex min-h-0 flex-1 flex-col gap-2 overflow-auto group-data-[collapsible=icon]:overflow-hidden",
        className
      )}
      {...props}
    />
  )
})
SidebarContent.displayName = "SidebarContent"

const SidebarGroup = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div">
>(({ className, ...props }, ref) => {
  return (
    <div
      ref={ref}
      data-sidebar="group"
      className={cn("relative flex w-full min-w-0 flex-col p-2", className)}
      {...props}
    />
  )
})
SidebarGroup.displayName = "SidebarGroup"

const SidebarGroupLabel = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div"> & { asChild?: boolean }
>(({ className, asChild = false, ...props }, ref) => {
  const Comp = asChild ? Slot : "div"

  return (
    <Comp
      ref={ref}
      data-sidebar="group-label"
      className={cn(
        "duration-200 flex h-8 shrink-0 items-center rounded-md px-2 text-xs font-medium text-sidebar-foreground/70 outline-none ring-sidebar-ring transition-[margin,opa] ease-linear focus-visible:ring-2 [&>svg]:size-4 [&>svg]:shrink-0",
        "group-data-[collapsible=icon]:-mt-8 group-data-[collapsible=icon]:opacity-0",
        className
      )}
      {...props}
    />
  )
})
SidebarGroupLabel.displayName = "SidebarGroupLabel"

const SidebarGroupAction = React.forwardRef<
  HTMLButtonElement,
  React.ComponentProps<"button"> & { asChild?: boolean }
>(({ className, asChild = false, ...props }, ref) => {
  const Comp = asChild ? Slot : "button"

  return (
    <Comp
      ref={ref}
      data-sidebar="group-action"
      className={cn(
        "absolute right-3 top-3.5 flex aspect-square w-5 items-center justify-center rounded-md p-0 text-sidebar-foreground outline-none ring-sidebar-ring transition-transform hover:bg-sidebar-accent hover:text-sidebar-accent-foreground focus-visible:ring-2 [&>svg]:size-4 [&>svg]:shrink-0",
        // Increases the hit area of the button on mobile.
        "after:absolute after:-inset-2 after:md:hidden",
        "group-data-[collapsible=icon]:hidden",
        className
      )}
      {...props}
    />
  )
})
SidebarGroupAction.displayName = "SidebarGroupAction"

const SidebarGroupContent = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div">
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    data-sidebar="group-content"
    className={cn("w-full text-sm", className)}
    {...props}
  />
))
SidebarGroupContent.displayName = "SidebarGroupContent"

const SidebarMenu = React.forwardRef<
  HTMLUListElement,
  React.ComponentProps<"ul">
>(({ className, ...props }, ref) => (
  <ul
    ref={ref}
    data-sidebar="menu"
    className={cn("flex w-full min-w-0 flex-col gap-1", className)}
    {...props}
  />
))
SidebarMenu.displayName = "SidebarMenu"

const SidebarMenuItem = React.forwardRef<
  HTMLLIElement,
  React.ComponentProps<"li">
>(({ className, ...props }, ref) => (
  <li
    ref={ref}
    data-sidebar="menu-item"
    className={cn("group/menu-item relative", className)}
    {...props}
  />
))
SidebarMenuItem.displayName = "SidebarMenuItem"

const sidebarMenuButtonVariants = cva(
  "peer/menu-button flex w-full items-center gap-2 overflow-hidden rounded-md p-2 text-left text-sm outline-none ring-sidebar-ring transition-[width,height,padding] hover:bg-sidebar-accent hover:text-sidebar-accent-foreground focus-visible:ring-2 active:bg-sidebar-accent active:text-sidebar-accent-foreground disabled:pointer-events-none disabled:opacity-50 group-has-[[data-sidebar=menu-action]]/menu-item:pr-8 aria-disabled:pointer-events-none aria-disabled:opacity-50 data-[active=true]:bg-sidebar-accent data-[active=true]:font-medium data-[active=true]:text-sidebar-accent-foreground data-[state=open]:hover:bg-sidebar-accent data-[state=open]:hover:text-sidebar-accent-foreground group-data-[collapsible=icon]:!size-8 group-data-[collapsible=icon]:!p-2 [&>span:last-child]:truncate [&>svg]:size-4 [&>svg]:shrink-0",
  {
    variants: {
      variant: {
        default: "hover:bg-sidebar-accent hover:text-sidebar-accent-foreground",
        outline:
          "bg-background shadow-[0_0_0_1px_hsl(var(--sidebar-border))] hover:bg-sidebar-accent hover:text-sidebar-accent-foreground hover:shadow-[0_0_0_1px_hsl(var(--sidebar-accent))]",
      },
      size: {
        default: "h-8 text-sm",
        sm: "h-7 text-xs",
        lg: "h-12 text-sm group-data-[collapsible=icon]:!p-0",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

const SidebarMenuButton = React.forwardRef<
  HTMLButtonElement,
  React.ComponentProps<"button"> & {
    asChild?: boolean
    isActive?: boolean
    tooltip?: string | React.ComponentProps<typeof TooltipContent>
  } & VariantProps<typeof sidebarMenuButtonVariants>
>(
  (
    {
      asChild = false,
      isActive = false,
      variant = "default",
      size = "default",
      tooltip,
      className,
      ...props
    },
    ref
  ) => {
    const Comp = asChild ? Slot : "button"
    const { isMobile, state } = useSidebar()

    const button = (
      <Comp
        ref={ref}
        data-sidebar="menu-button"
        data-size={size}
        data-active={isActive}
        className={cn(sidebarMenuButtonVariants({ variant, size }), className)}
        {...props}
      />
    )

    if (!tooltip) {
      return button
    }

    if (typeof tooltip === "string") {
      tooltip = {
        children: tooltip,
      }
    }

    return (
      <Tooltip>
        <TooltipTrigger asChild>{button}</TooltipTrigger>
        <TooltipContent
          side="right"
          align="center"
          hidden={state !== "collapsed" || isMobile}
          {...tooltip}
        />
      </Tooltip>
    )
  }
)
SidebarMenuButton.displayName = "SidebarMenuButton"

const SidebarMenuAction = React.forwardRef<
  HTMLButtonElement,
  React.ComponentProps<"button"> & {
    asChild?: boolean
    showOnHover?: boolean
  }
>(({ className, asChild = false, showOnHover = false, ...props }, ref) => {
  const Comp = asChild ? Slot : "button"

  return (
    <Comp
      ref={ref}
      data-sidebar="menu-action"
      className={cn(
        "absolute right-1 top-1.5 flex aspect-square w-5 items-center justify-center rounded-md p-0 text-sidebar-foreground outline-none ring-sidebar-ring transition-transform hover:bg-sidebar-accent hover:text-sidebar-accent-foreground focus-visible:ring-2 peer-hover/menu-button:text-sidebar-accent-foreground [&>svg]:size-4 [&>svg]:shrink-0",
        // Increases the hit area of the button on mobile.
        "after:absolute after:-inset-2 after:md:hidden",
        "peer-data-[size=sm]/menu-button:top-1",
        "peer-data-[size=default]/menu-button:top-1.5",
        "peer-data-[size=lg]/menu-button:top-2.5",
        "group-data-[collapsible=icon]:hidden",
        showOnHover &&
          "group-focus-within/menu-item:opacity-100 group-hover/menu-item:opacity-100 data-[state=open]:opacity-100 peer-data-[active=true]/menu-button:text-sidebar-accent-foreground md:opacity-0",
        className
      )}
      {...props}
    />
  )
})
SidebarMenuAction.displayName = "SidebarMenuAction"

const SidebarMenuBadge = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div">
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    data-sidebar="menu-badge"
    className={cn(
      "absolute right-1 flex h-5 min-w-5 items-center justify-center rounded-md px-1 text-xs font-medium tabular-nums text-sidebar-foreground select-none pointer-events-none",
      "peer-hover/menu-button:text-sidebar-accent-foreground peer-data-[active=true]/menu-button:text-sidebar-accent-foreground",
      "peer-data-[size=sm]/menu-button:top-1",
      "peer-data-[size=default]/menu-button:top-1.5",
      "peer-data-[size=lg]/menu-button:top-2.5",
      "group-data-[collapsible=icon]:hidden",
      className
    )}
    {...props}
  />
))
SidebarMenuBadge.displayName = "SidebarMenuBadge"

const SidebarMenuSkeleton = React.forwardRef<
  HTMLDivElement,
  React.ComponentProps<"div"> & {
    showIcon?: boolean
  }
>(({ className, showIcon = false, ...props }, ref) => {
  // Random width between 50 to 90%.
  const width = React.useMemo(() => {
    return `${Math.floor(Math.random() * 40) + 50}%`
  }, [])

  return (
    <div
      ref={ref}
      data-sidebar="menu-skeleton"
      className={cn("rounded-md h-8 flex gap-2 px-2 items-center", className)}
      {...props}
    >
      {showIcon && (
        <Skeleton
          className="size-4 rounded-md"
          data-sidebar="menu-skeleton-icon"
        />
      )}
      <Skeleton
        className="h-4 flex-1 max-w-[--skeleton-width]"
        data-sidebar="menu-skeleton-text"
        style={
          {
            "--skeleton-width": width,
          } as React.CSSProperties
        }
      />
    </div>
  )
})
SidebarMenuSkeleton.displayName = "SidebarMenuSkeleton"

const SidebarMenuSub = React.forwardRef<
  HTMLUListElement,
  React.ComponentProps<"ul">
>(({ className, ...props }, ref) => (
  <ul
    ref={ref}
    data-sidebar="menu-sub"
    className={cn(
      "mx-3.5 flex min-w-0 translate-x-px flex-col gap-1 border-l border-sidebar-border px-2.5 py-0.5",
      "group-data-[collapsible=icon]:hidden",
      className
    )}
    {...props}
  />
))
SidebarMenuSub.displayName = "SidebarMenuSub"

const SidebarMenuSubItem = React.forwardRef<
  HTMLLIElement,
  React.ComponentProps<"li">
>(({ ...props }, ref) => <li ref={ref} {...props} />)
SidebarMenuSubItem.displayName = "SidebarMenuSubItem"

const SidebarMenuSubButton = React.forwardRef<
  HTMLAnchorElement,
  React.ComponentProps<"a"> & {
    asChild?: boolean
    size?: "sm" | "md"
    isActive?: boolean
  }
>(({ asChild = false, size = "md", isActive, className, ...props }, ref) => {
  const Comp = asChild ? Slot : "a"

  return (
    <Comp
      ref={ref}
      data-sidebar="menu-sub-button"
      data-size={size}
      data-active={isActive}
      className={cn(
        "flex h-7 min-w-0 -translate-x-px items-center gap-2 overflow-hidden rounded-md px-2 text-sidebar-foreground outline-none ring-sidebar-ring hover:bg-sidebar-accent hover:text-sidebar-accent-foreground focus-visible:ring-2 active:bg-sidebar-accent active:text-sidebar-accent-foreground disabled:pointer-events-none disabled:opacity-50 aria-disabled:pointer-events-none aria-disabled:opacity-50 [&>span:last-child]:truncate [&>svg]:size-4 [&>svg]:shrink-0 [&>svg]:text-sidebar-accent-foreground",
        "data-[active=true]:bg-sidebar-accent data-[active=true]:text-sidebar-accent-foreground",
        size === "sm" && "text-xs",
        size === "md" && "text-sm",
        "group-data-[collapsible=icon]:hidden",
        className
      )}
      {...props}
    />
  )
})
SidebarMenuSubButton.displayName = "SidebarMenuSubButton"

export {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupAction,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarInput,
  SidebarInset,
  SidebarMenu,
  SidebarMenuAction,
  SidebarMenuBadge,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarMenuSkeleton,
  SidebarMenuSub,
  SidebarMenuSubButton,
  SidebarMenuSubItem,
  SidebarProvider,
  SidebarRail,
  SidebarSeparator,
  SidebarTrigger,
  useSidebar,
}
EOF

cat <<'EOF' > src/components/ui/skeleton.tsx
import { cn } from "@/lib/utils"

function Skeleton({
  className,
  ...props
}: React.HTMLAttributes<HTMLDivElement>) {
  return (
    <div
      className={cn("animate-pulse rounded-md bg-muted", className)}
      {...props}
    />
  )
}

export { Skeleton }
EOF

cat <<'EOF' > src/components/ui/slider.tsx
"use client"

import * as React from "react"
import * as SliderPrimitive from "@radix-ui/react-slider"

import { cn } from "@/lib/utils"

const Slider = React.forwardRef<
  React.ElementRef<typeof SliderPrimitive.Root>,
  React.ComponentPropsWithoutRef<typeof SliderPrimitive.Root>
>(({ className, ...props }, ref) => (
  <SliderPrimitive.Root
    ref={ref}
    className={cn(
      "relative flex w-full touch-none select-none items-center",
      className
    )}
    {...props}
  >
    <SliderPrimitive.Track className="relative h-2 w-full grow overflow-hidden rounded-full bg-secondary">
      <SliderPrimitive.Range className="absolute h-full bg-primary" />
    </SliderPrimitive.Track>
    <SliderPrimitive.Thumb className="block h-5 w-5 rounded-full border-2 border-primary bg-background ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50" />
  </SliderPrimitive.Root>
))
Slider.displayName = SliderPrimitive.Root.displayName

export { Slider }
EOF

cat <<'EOF' > src/components/ui/switch.tsx
"use client"

import * as React from "react"
import * as SwitchPrimitives from "@radix-ui/react-switch"

import { cn } from "@/lib/utils"

const Switch = React.forwardRef<
  React.ElementRef<typeof SwitchPrimitives.Root>,
  React.ComponentPropsWithoutRef<typeof SwitchPrimitives.Root>
>(({ className, ...props }, ref) => (
  <SwitchPrimitives.Root
    className={cn(
      "peer inline-flex h-6 w-11 shrink-0 cursor-pointer items-center rounded-full border-2 border-transparent transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 focus-visible:ring-offset-background disabled:cursor-not-allowed disabled:opacity-50 data-[state=checked]:bg-primary data-[state=unchecked]:bg-input",
      className
    )}
    {...props}
    ref={ref}
  >
    <SwitchPrimitives.Thumb
      className={cn(
        "pointer-events-none block h-5 w-5 rounded-full bg-background shadow-lg ring-0 transition-transform data-[state=checked]:translate-x-5 data-[state=unchecked]:translate-x-0"
      )}
    />
  </SwitchPrimitives.Root>
))
Switch.displayName = SwitchPrimitives.Root.displayName

export { Switch }
EOF

cat <<'EOF' > src/components/ui/table.tsx
import * as React from "react"

import { cn } from "@/lib/utils"

const Table = React.forwardRef<
  HTMLTableElement,
  React.HTMLAttributes<HTMLTableElement>
>(({ className, ...props }, ref) => (
  <div className="relative w-full overflow-auto">
    <table
      ref={ref}
      className={cn("w-full caption-bottom text-sm", className)}
      {...props}
    />
  </div>
))
Table.displayName = "Table"

const TableHeader = React.forwardRef<
  HTMLTableSectionElement,
  React.HTMLAttributes<HTMLTableSectionElement>
>(({ className, ...props }, ref) => (
  <thead ref={ref} className={cn("[&_tr]:border-b", className)} {...props} />
))
TableHeader.displayName = "TableHeader"

const TableBody = React.forwardRef<
  HTMLTableSectionElement,
  React.HTMLAttributes<HTMLTableSectionElement>
>(({ className, ...props }, ref) => (
  <tbody
    ref={ref}
    className={cn("[&_tr:last-child]:border-0", className)}
    {...props}
  />
))
TableBody.displayName = "TableBody"

const TableFooter = React.forwardRef<
  HTMLTableSectionElement,
  React.HTMLAttributes<HTMLTableSectionElement>
>(({ className, ...props }, ref) => (
  <tfoot
    ref={ref}
    className={cn(
      "border-t bg-muted/50 font-medium [&>tr]:last:border-b-0",
      className
    )}
    {...props}
  />
))
TableFooter.displayName = "TableFooter"

const TableRow = React.forwardRef<
  HTMLTableRowElement,
  React.HTMLAttributes<HTMLTableRowElement>
>(({ className, ...props }, ref) => (
  <tr
    ref={ref}
    className={cn(
      "border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted",
      className
    )}
    {...props}
  />
))
TableRow.displayName = "TableRow"

const TableHead = React.forwardRef<
  HTMLTableCellElement,
  React.ThHTMLAttributes<HTMLTableCellElement>
>(({ className, ...props }, ref) => (
  <th
    ref={ref}
    className={cn(
      "h-12 px-4 text-left align-middle font-medium text-muted-foreground [&:has([role=checkbox])]:pr-0",
      className
    )}
    {...props}
  />
))
TableHead.displayName = "TableHead"

const TableCell = React.forwardRef<
  HTMLTableCellElement,
  React.TdHTMLAttributes<HTMLTableCellElement>
>(({ className, ...props }, ref) => (
  <td
    ref={ref}
    className={cn("p-4 align-middle [&:has([role=checkbox])]:pr-0", className)}
    {...props}
  />
))
TableCell.displayName = "TableCell"

const TableCaption = React.forwardRef<
  HTMLTableCaptionElement,
  React.HTMLAttributes<HTMLTableCaptionElement>
>(({ className, ...props }, ref) => (
  <caption
    ref={ref}
    className={cn("mt-4 text-sm text-muted-foreground", className)}
    {...props}
  />
))
TableCaption.displayName = "TableCaption"

export {
  Table,
  TableHeader,
  TableBody,
  TableFooter,
  TableHead,
  TableRow,
  TableCell,
  TableCaption,
}
EOF

cat <<'EOF' > src/components/ui/tabs.tsx
"use client"

import * as React from "react"
import * as TabsPrimitive from "@radix-ui/react-tabs"

import { cn } from "@/lib/utils"

const Tabs = TabsPrimitive.Root

const TabsList = React.forwardRef<
  React.ElementRef<typeof TabsPrimitive.List>,
  React.ComponentPropsWithoutRef<typeof TabsPrimitive.List>
>(({ className, ...props }, ref) => (
  <TabsPrimitive.List
    ref={ref}
    className={cn(
      "inline-flex h-10 items-center justify-center rounded-md bg-muted p-1 text-muted-foreground",
      className
    )}
    {...props}
  />
))
TabsList.displayName = TabsPrimitive.List.displayName

const TabsTrigger = React.forwardRef<
  React.ElementRef<typeof TabsPrimitive.Trigger>,
  React.ComponentPropsWithoutRef<typeof TabsPrimitive.Trigger>
>(({ className, ...props }, ref) => (
  <TabsPrimitive.Trigger
    ref={ref}
    className={cn(
      "inline-flex items-center justify-center whitespace-nowrap rounded-sm px-3 py-1.5 text-sm font-medium ring-offset-background transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 data-[state=active]:bg-background data-[state=active]:text-foreground data-[state=active]:shadow-sm",
      className
    )}
    {...props}
  />
))
TabsTrigger.displayName = TabsPrimitive.Trigger.displayName

const TabsContent = React.forwardRef<
  React.ElementRef<typeof TabsPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof TabsPrimitive.Content>
>(({ className, ...props }, ref) => (
  <TabsPrimitive.Content
    ref={ref}
    className={cn(
      "mt-2 ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
      className
    )}
    {...props}
  />
))
TabsContent.displayName = TabsPrimitive.Content.displayName

export { Tabs, TabsList, TabsTrigger, TabsContent }
EOF

cat <<'EOF' > src/components/ui/textarea.tsx
import * as React from 'react';

import {cn} from '@/lib/utils';

const Textarea = React.forwardRef<HTMLTextAreaElement, React.ComponentProps<'textarea'>>(
  ({className, ...props}, ref) => {
    return (
      <textarea
        className={cn(
          'flex min-h-[80px] w-full rounded-md border border-input bg-background px-3 py-2 text-base ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 md:text-sm',
          'read-only:bg-muted/50 read-only:focus-visible:ring-0 read-only:cursor-default read-only:border-0',
          className
        )}
        ref={ref}
        {...props}
      />
    );
  }
);
Textarea.displayName = 'Textarea';

export {Textarea};
EOF

cat <<'EOF' > src/components/ui/toast.tsx
"use client"

import * as React from "react"
import * as ToastPrimitives from "@radix-ui/react-toast"
import { cva, type VariantProps } from "class-variance-authority"
import { X } from "lucide-react"

import { cn } from "@/lib/utils"

const ToastProvider = ToastPrimitives.Provider

const ToastViewport = React.forwardRef<
  React.ElementRef<typeof ToastPrimitives.Viewport>,
  React.ComponentPropsWithoutRef<typeof ToastPrimitives.Viewport>
>(({ className, ...props }, ref) => (
  <ToastPrimitives.Viewport
    ref={ref}
    className={cn(
      "fixed top-0 z-[100] flex max-h-screen w-full flex-col-reverse p-4 sm:bottom-0 sm:right-0 sm:top-auto sm:flex-col md:max-w-[420px]",
      className
    )}
    {...props}
  />
))
ToastViewport.displayName = ToastPrimitives.Viewport.displayName

const toastVariants = cva(
  "group pointer-events-auto relative flex w-full items-center justify-between space-x-4 overflow-hidden rounded-md border p-6 pr-8 shadow-lg transition-all data-[swipe=cancel]:translate-x-0 data-[swipe=end]:translate-x-[var(--radix-toast-swipe-end-x)] data-[swipe=move]:translate-x-[var(--radix-toast-swipe-move-x)] data-[swipe=move]:transition-none data-[state=open]:animate-in data-[state=closed]:animate-out data-[swipe=end]:animate-out data-[state=closed]:fade-out-80 data-[state=closed]:slide-out-to-right-full data-[state=open]:slide-in-from-top-full data-[state=open]:sm:slide-in-from-bottom-full",
  {
    variants: {
      variant: {
        default: "border bg-background text-foreground",
        destructive:
          "destructive group border-destructive bg-destructive text-destructive-foreground",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
)

const Toast = React.forwardRef<
  React.ElementRef<typeof ToastPrimitives.Root>,
  React.ComponentPropsWithoutRef<typeof ToastPrimitives.Root> &
    VariantProps<typeof toastVariants>
>(({ className, variant, ...props }, ref) => {
  return (
    <ToastPrimitives.Root
      ref={ref}
      className={cn(toastVariants({ variant }), className)}
      {...props}
    />
  )
})
Toast.displayName = ToastPrimitives.Root.displayName

const ToastAction = React.forwardRef<
  React.ElementRef<typeof ToastPrimitives.Action>,
  React.ComponentPropsWithoutRef<typeof ToastPrimitives.Action>
>(({ className, ...props }, ref) => (
  <ToastPrimitives.Action
    ref={ref}
    className={cn(
      "inline-flex h-8 shrink-0 items-center justify-center rounded-md border bg-transparent px-3 text-sm font-medium ring-offset-background transition-colors hover:bg-secondary focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 group-[.destructive]:border-muted/40 group-[.destructive]:hover:border-destructive/30 group-[.destructive]:hover:bg-destructive group-[.destructive]:hover:text-destructive-foreground group-[.destructive]:focus:ring-destructive",
      className
    )}
    {...props}
  />
))
ToastAction.displayName = ToastPrimitives.Action.displayName

const ToastClose = React.forwardRef<
  React.ElementRef<typeof ToastPrimitives.Close>,
  React.ComponentPropsWithoutRef<typeof ToastPrimitives.Close>
>(({ className, ...props }, ref) => (
  <ToastPrimitives.Close
    ref={ref}
    className={cn(
      "absolute right-2 top-2 rounded-md p-1 text-foreground/50 opacity-0 transition-opacity hover:text-foreground focus:opacity-100 focus:outline-none focus:ring-2 group-hover:opacity-100 group-[.destructive]:text-red-300 group-[.destructive]:hover:text-red-50 group-[.destructive]:focus:ring-red-400 group-[.destructive]:focus:ring-offset-red-600",
      className
    )}
    toast-close=""
    {...props}
  >
    <X className="h-4 w-4" />
  </ToastPrimitives.Close>
))
ToastClose.displayName = ToastPrimitives.Close.displayName

const ToastTitle = React.forwardRef<
  React.ElementRef<typeof ToastPrimitives.Title>,
  React.ComponentPropsWithoutRef<typeof ToastPrimitives.Title>
>(({ className, ...props }, ref) => (
  <ToastPrimitives.Title
    ref={ref}
    className={cn("text-sm font-semibold", className)}
    {...props}
  />
))
ToastTitle.displayName = ToastPrimitives.Title.displayName

const ToastDescription = React.forwardRef<
  React.ElementRef<typeof ToastPrimitives.Description>,
  React.ComponentPropsWithoutRef<typeof ToastPrimitives.Description>
>(({ className, ...props }, ref) => (
  <ToastPrimitives.Description
    ref={ref}
    className={cn("text-sm opacity-90", className)}
    {...props}
  />
))
ToastDescription.displayName = ToastPrimitives.Description.displayName

type ToastProps = React.ComponentPropsWithoutRef<typeof Toast>

type ToastActionElement = React.ReactElement<typeof ToastAction>

export {
  type ToastProps,
  type ToastActionElement,
  ToastProvider,
  ToastViewport,
  Toast,
  ToastTitle,
  ToastDescription,
  ToastClose,
  ToastAction,
}
EOF

cat <<'EOF' > src/components/ui/toaster.tsx
"use client"

import { useToast } from "@/hooks/use-toast"
import {
  Toast,
  ToastClose,
  ToastDescription,
  ToastProvider,
  ToastTitle,
  ToastViewport,
} from "@/components/ui/toast"

export function Toaster() {
  const { toasts } = useToast()

  return (
    <ToastProvider>
      {toasts.map(function ({ id, title, description, action, ...props }) {
        return (
          <Toast key={id} {...props}>
            <div className="grid gap-1">
              {title && <ToastTitle>{title}</ToastTitle>}
              {description && (
                <ToastDescription>{description}</ToastDescription>
              )}
            </div>
            {action}
            <ToastClose />
          </Toast>
        )
      })}
      <ToastViewport />
    </ToastProvider>
  )
}
EOF

cat <<'EOF' > src/components/ui/tooltip.tsx
"use client"

import * as React from "react"
import * as TooltipPrimitive from "@radix-ui/react-tooltip"

import { cn } from "@/lib/utils"

const TooltipProvider = TooltipPrimitive.Provider

const Tooltip = TooltipPrimitive.Root

const TooltipTrigger = TooltipPrimitive.Trigger

const TooltipContent = React.forwardRef<
  React.ElementRef<typeof TooltipPrimitive.Content>,
  React.ComponentPropsWithoutRef<typeof TooltipPrimitive.Content>
>(({ className, sideOffset = 4, ...props }, ref) => (
  <TooltipPrimitive.Content
    ref={ref}
    sideOffset={sideOffset}
    className={cn(
      "z-50 overflow-hidden rounded-md border bg-popover px-3 py-1.5 text-sm text-popover-foreground shadow-md animate-in fade-in-0 zoom-in-95 data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=closed]:zoom-out-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2",
      className
    )}
    {...props}
  />
))
TooltipContent.displayName = TooltipPrimitive.Content.displayName

export { Tooltip, TooltipTrigger, TooltipContent, TooltipProvider }
EOF

# src/app
cat <<'EOF' > src/app/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --background: 224 71% 4%;
    --foreground: 213 31% 91%;
    --card: 222 84% 4.9%;
    --card-foreground: 210 40% 98%;
    --popover: 222 84% 4.9%;
    --popover-foreground: 210 40% 98%;
    --primary: 262.1 83.3% 57.8%;
    --primary-foreground: 210 40% 98%;
    --secondary: 217.2 32.6% 17.5%;
    --secondary-foreground: 210 40% 98%;
    --muted: 217.2 32.6% 17.5%;
    --muted-foreground: 215 20.2% 65.1%;
    --accent: 217.2 32.6% 17.5%;
    --accent-foreground: 210 40% 98%;
    --destructive: 0 72.2% 50.6%;
    --destructive-foreground: 0 85.7% 97.3%;
    --border: 217.2 32.6% 17.5%;
    --input: 217.2 32.6% 17.5%;
    --ring: 262.1 83.3% 57.8%;
    --radius: 0.75rem;
  }
 
  .dark {
    --background: 224 71% 4%;
    --foreground: 213 31% 91%;
    --card: 222 84% 4.9%;
    --card-foreground: 210 40% 98%;
    --popover: 222 84% 4.9%;
    --popover-foreground: 210 40% 98%;
    --primary: 263.4 95.2% 56.1%;
    --primary-foreground: 210 40% 98%;
    --secondary: 217.2 32.6% 17.5%;
    --secondary-foreground: 210 40% 98%;
    --muted: 217.2 32.6% 17.5%;
    --muted-foreground: 215 20.2% 65.1%;
    --accent: 217.2 32.6% 17.5%;
    --accent-foreground: 210 40% 98%;
    --destructive: 0 72.2% 50.6%;
    --destructive-foreground: 0 85.7% 97.3%;
    --border: 217.2 32.6% 17.5%;
    --input: 217.2 32.6% 17.5%;
    --ring: 263.4 95.2% 56.1%;
  }
}

@layer base {
  * {
    @apply border-border;
  }
  body {
    @apply bg-background text-foreground;
    font-feature-settings: "rlig" 1, "calt" 1;
  }
}

@layer utilities {
  @keyframes fade-in-up {
    from {
      opacity: 0;
      transform: translateY(10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
  @keyframes fade-in-down {
    from {
      opacity: 0;
      transform: translateY(-10px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .animate-fade-in-up {
    animation: fade-in-up 0.5s ease-out forwards;
    animation-delay: 0.2s;
    opacity: 0;
  }
  .animate-fade-in-down {
    animation: fade-in-down 0.5s ease-out forwards;
    opacity: 0;
  }
}
EOF

cat <<'EOF' > src/app/layout.tsx
import type { Metadata } from "next";
import { Inter, Patrick_Hand } from "next/font/google";
import "./globals.css";
import { Toaster } from "@/components/ui/toaster";
import { cn } from "@/lib/utils";

const fontBody = Inter({
  subsets: ["latin"],
  variable: "--font-body",
});

const fontHeadline = Patrick_Hand({
  subsets: ["latin"],
  weight: ["400"],
  variable: "--font-headline",
});

export const metadata: Metadata = {
  title: "Keizer AI Suite",
  description: "Your personal AI Assistant",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark" style={{ colorScheme: "dark" }} suppressHydrationWarning>
      <body
        className={cn(
          "min-h-screen bg-background font-body antialiased",
          fontBody.variable,
          fontHeadline.variable
        )}
      >
        {children}
        <Toaster />
      </body>
    </html>
  );
}
EOF

cat <<'EOF' > src/app/page.tsx
import {
  MessageCircle,
  FileText,
  PenSquare,
  Image,
  FileVideo,
  Blocks,
  Sigma,
  CodeXml,
  Mail,
  Megaphone,
  Clipboard,
} from "lucide-react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { KeizerLogo } from "@/components/keizer-logo";

const tools = [
  {
    name: "AI Chat",
    href: "/dashboard",
    icon: MessageCircle,
    description: "Engage in natural conversations with an intelligent AI assistant.",
  },
  {
    name: "Report Generator",
    href: "/report-generator",
    icon: FileText,
    description: "Generate comprehensive and well-structured reports on any topic.",
  },
  {
    name: "Article Writer",
    href: "/article-writer",
    icon: PenSquare,
    description: "Create high-quality articles and journal entries effortlessly.",
  },
  {
    name: "Image Editor",
    href: "/image-editor",
    icon: Image,
    description: "Describe your desired edits and let AI transform your images.",
  },
  {
    name: "Script Writer",
    href: "/script-writer",
    icon: FileVideo,
    description: "Generate scripts for videos, podcasts, and other creative projects.",
  },
  {
    name: "Resume Writer",
    href: "/resume-writer",
    icon: Clipboard,
    description: "Build a professional resume or CV with AI-powered assistance.",
  },
  {
    name: "Content Creation",
    href: "/content-creation",
    icon: Blocks,
    description: "Generate compelling marketing copy and slogans for your brand.",
  },
  {
    name: "Math Solver",
    href: "/math-solver",
    icon: Sigma,
    description: "Solve complex mathematical problems and equations with ease.",
  },
  {
    name: "Code Generator",
    href: "/code-generator",
    icon: CodeXml,
    description: "Create code snippets in various languages from natural language.",
  },
  {
    name: "Email Responder",
    href: "/email-responder",
    icon: Mail,
    description: "Draft professional and effective email replies in seconds.",
  },
  {
    name: "Social Media Post",
    href: "/social-media-post-generator",
    icon: Megaphone,
    description: "Create engaging social media posts tailored for any platform.",
  },
];

export default function LandingPage() {
  return (
    <div className="flex min-h-screen w-full flex-col bg-background">
      <header className="sticky top-0 z-50 flex items-center justify-between p-4 bg-background/80 backdrop-blur-sm border-b border-border">
        <div className="flex items-center gap-2">
          <KeizerLogo />
          <span className="font-headline text-xl text-primary">Keizer</span>
        </div>
        <nav className="flex items-center gap-4">
          <Link href="/login">
             <Button variant="ghost">Login</Button>
          </Link>
          <Link href="/signup">
             <Button>Sign Up</Button>
          </Link>
        </nav>
      </header>

      <main className="flex-1">
        <section className="container mx-auto flex flex-col items-center justify-center space-y-6 py-24 text-center">
          <h1 className="font-headline text-6xl md:text-8xl text-primary animate-fade-in-down">
            Your Ultimate AI Assistant
          </h1>
          <p className="mt-4 max-w-2xl mx-auto text-lg text-muted-foreground animate-fade-in-up">
            Meet Keizer – a powerful suite of AI tools designed to enhance your
            productivity, creativity, and problem-solving capabilities. Choose
            any tool below to get started.
          </p>
          <Link href="/dashboard">
            <Button size="lg" className="mt-6">Get Started for Free</Button>
          </Link>
        </section>

        <section className="container mx-auto pb-24">
           <div className="mt-12 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {tools.map((tool, i) => (
              <Link href={tool.href} key={tool.name}>
                <Card 
                  className="h-full flex flex-col justify-between cursor-pointer group"
                  style={{ animationDelay: `${i * 100}ms` }}
                >
                    <CardHeader>
                      <div className="flex items-center gap-4">
                        <tool.icon className="h-8 w-8 text-primary transition-transform duration-300 group-hover:scale-125" />
                        <CardTitle className="font-headline text-2xl">{tool.name}</CardTitle>
                      </div>
                    </CardHeader>
                    <CardContent>
                      <CardDescription>{tool.description}</CardDescription>
                    </CardContent>
                </Card>
              </Link>
            ))}
          </div>
        </section>
      </main>
       
       <footer className="border-t">
        <div className="container flex flex-col items-center justify-center gap-4 py-10 md:h-24 md:flex-row md:py-0">
          <p className="text-center text-sm leading-loose text-muted-foreground">
            © {new Date().getFullYear()} Keizer AI. All Rights Reserved.
          </p>
        </div>
      </footer>
    </div>
  );
}
EOF

# src/app/(app) layout and pages
cat <<'EOF' > src/app/'(app)'/layout.tsx
"use client";

import * as React from "react";
import {
  Sidebar,
  SidebarProvider,
  SidebarTrigger,
  SidebarInset,
  SidebarHeader,
  SidebarContent,
  SidebarMenu,
  SidebarMenuItem,
  SidebarMenuButton,
} from "@/components/ui/sidebar";
import { KeizerLogo } from "@/components/keizer-logo";
import {
  MessageCircle,
  FileText,
  PenSquare,
  Image,
  FileVideo,
  Blocks,
  Sigma,
  CodeXml,
  Mail,
  Megaphone,
  Clipboard,
} from "lucide-react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { motion } from "framer-motion";

const toolLinks = [
  {
    name: "AI Chat",
    href: "/dashboard",
    icon: MessageCircle,
  },
  {
    name: "Report Generator",
    href: "/report-generator",
    icon: FileText,
  },
  {
    name: "Article Writer",
    href: "/article-writer",
    icon: PenSquare,
  },
  {
    name: "Image Editor",
    href: "/image-editor",
    icon: Image,
  },
  {
    name: "Script Writer",
    href: "/script-writer",
    icon: FileVideo,
  },
    {
    name: "Resume Writer",
    href: "/resume-writer",
    icon: Clipboard,
  },
  {
    name: "Content Creation",
    href: "/content-creation",
    icon: Blocks,
  },
  {
    name: "Math Solver",
    href: "/math-solver",
    icon: Sigma,
  },
  {
    name: "Code Generator",
    href: "/code-generator",
    icon: CodeXml,
  },
  {
    name: "Email Responder",
    href: "/email-responder",
    icon: Mail,
  },
  {
    name: "Social Media Post",
    href: "/social-media-post-generator",
    icon: Megaphone,
  },
];

export default function AppLayout({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();

  return (
    <SidebarProvider>
      <div className="flex min-h-screen">
        <Sidebar>
          <SidebarHeader>
            <div className="flex items-center gap-3">
              <KeizerLogo />
              <h1 className="font-headline text-lg font-semibold text-primary">Keizer</h1>
            </div>
          </SidebarHeader>
          <SidebarContent>
            <SidebarMenu>
              {toolLinks.map((link) => (
                <SidebarMenuItem key={link.href}>
                  <Link href={link.href} className="w-full">
                    <SidebarMenuButton
                      isActive={pathname === link.href}
                      tooltip={link.name}
                    >
                      <link.icon />
                      <span>{link.name}</span>
                    </SidebarMenuButton>
                  </Link>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarContent>
        </Sidebar>
        <SidebarInset>
          <header className="sticky top-0 z-10 flex h-14 items-center gap-4 border-b bg-background px-4 sm:static sm:h-auto sm:border-0 sm:bg-transparent sm:px-6 md:hidden">
            <SidebarTrigger />
             <div className="flex items-center gap-2">
              <KeizerLogo className="h-6 w-6"/>
              <h1 className="font-headline text-lg font-semibold text-primary">Keizer</h1>
            </div>
          </header>
          <main className="flex-1 p-4 sm:p-6">
             <motion.div
              key={pathname}
              initial={{ opacity: 0, y: 5 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.2, ease: "easeOut" }}
            >
              {children}
            </motion.div>
          </main>
        </SidebarInset>
      </div>
    </SidebarProvider>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/dashboard/page.tsx
"use client";

import { useState, useRef, useEffect } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { chat } from "@/ai/flows/chat-flow";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { LoadingSpinner } from "@/components/loading-spinner";
import { SendHorizonal } from "lucide-react";
import { KeizerLogo } from "@/components/keizer-logo";
import { Form, FormField, FormItem, FormControl } from "@/components/ui/form";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";

const formSchema = z.object({
  message: z.string().min(1, "Message cannot be empty."),
});

// Define ChatMessage type locally as it cannot be exported from a 'use server' file.
export type ChatMessage = {
  role: "user" | "model";
  content: string;
};

export default function DashboardPage() {
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      message: "",
    },
  });
  
  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages, isLoading]);

  async function onSubmit(values: z.infer<typeof formSchema>) {
    const userMessage: ChatMessage = { role: "user", content: values.message };
    setMessages((prev) => [...prev, userMessage]);
    setIsLoading(true);
    form.reset();

    try {
      const history = [...messages, userMessage];
      const result = await chat({ history });
      const aiMessage: ChatMessage = { role: "model", content: result.reply || "" };
      setMessages((prev) => [...prev, aiMessage]);
    } catch (error) {
      console.error("Error with chat:", error);
      const errorMessage: ChatMessage = {
        role: "model",
        content: "I seem to be having some trouble right now. Please try again in a moment. If the problem continues, please ensure your API key is configured correctly.",
      };
      setMessages((prev) => [...prev, errorMessage]);
      toast({
        title: "Chat Error",
        description: "Failed to get a response from the AI. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="flex h-[calc(100vh-5rem)] flex-col">
      <div className="flex-1 overflow-y-auto p-4 space-y-6">
        <div className="flex items-start gap-4">
            <Avatar className="h-8 w-8 border-2 border-primary/50">
                <KeizerLogo />
            </Avatar>
            <div className="max-w-[75%] rounded-lg p-3 text-sm whitespace-pre-wrap shadow-md bg-muted rounded-bl-none">
                <p>Hello! I'm Keizer, your AI assistant. How can I help you today?</p>
            </div>
        </div>
        
        {messages.map((message, index) => (
          <div key={index} className={cn("flex items-start gap-4", message.role === "user" ? "justify-end" : "")}>
            {message.role === "model" && (
              <Avatar className="h-8 w-8 border-2 border-primary/50">
                <KeizerLogo />
              </Avatar>
            )}
            <div
              className={cn("max-w-[75%] rounded-lg p-3 text-sm whitespace-pre-wrap shadow-md",
                message.role === "user"
                  ? "bg-primary text-primary-foreground rounded-br-none"
                  : "bg-muted rounded-bl-none"
              )}
            >
              <p>{message.content}</p>
            </div>
            {message.role === "user" && (
              <Avatar className="h-8 w-8">
                <AvatarFallback>U</AvatarFallback>
              </Avatar>
            )}
          </div>
        ))}
        {isLoading && (
          <div className="flex items-start gap-4">
            <Avatar className="h-8 w-8 border">
               <KeizerLogo />
            </Avatar>
            <div className="max-w-[75%] rounded-lg bg-muted p-3">
              <LoadingSpinner />
            </div>
          </div>
        )}
        <div ref={messagesEndRef} />
      </div>
      <div className="border-t p-4 bg-background">
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="flex items-center gap-2">
            <FormField
              control={form.control}
              name="message"
              render={({ field }) => (
                <FormItem className="flex-1">
                  <FormControl>
                    <Input
                      placeholder="Ask me anything..."
                      autoComplete="off"
                      disabled={isLoading}
                      {...field}
                    />

                  </FormControl>
                </FormItem>
              )}
            />
            <Button type="submit" size="icon" disabled={isLoading}>
              <SendHorizonal className="h-4 w-4" />
              <span className="sr-only">Send</span>
            </Button>
          </form>
        </Form>
      </div>
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/article-writer/page.tsx
"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { writeArticle } from "@/ai/flows/article-writer";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { useToast } from "@/hooks/use-toast";
import { ClipboardCopy } from "lucide-react";

const formSchema = z.object({
  topic: z.string().min(10, { message: "Topic must be at least 10 characters." }),
  context: z.string().optional(),
  style: z.string().min(10, { message: "Style requirements must be at least 10 characters." }),
});

export default function ArticleWriterPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [article, setArticle] = useState("");
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      topic: "",
      context: "",
      style: "Formal tone, include citations where appropriate.",
    },
  });

  const handleCopy = () => {
    navigator.clipboard.writeText(article).then(() => {
      toast({ title: "Copied to clipboard!" });
    });
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setArticle("");
    try {
      const result = await writeArticle(values);
      setArticle(result.article);
    } catch (error) {
      console.error("Error writing article:", error);
      toast({
        title: "Error Generating Article",
        description: "There was an issue creating your article. Please check your details and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader>
          <CardTitle>Article & Journal Writer</CardTitle>
          <CardDescription>Generate well-structured articles and journal entries on any topic.</CardDescription>
        </CardHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="topic"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Topic</FormLabel>
                    <FormControl>
                      <Input placeholder="e.g., The future of renewable energy" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="context"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Context (Optional)</FormLabel>
                    <FormControl>
                      <Textarea placeholder="Provide any additional context or key points to include." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="style"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Style Requirements</FormLabel>
                    <FormControl>
                      <Textarea placeholder="e.g., Casual tone, for a blog post, no citations needed." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading}>
                {isLoading && <LoadingSpinner className="mr-2" />}
                Write Article
              </Button>
            </CardFooter>
          </form>
        </Form>
      </Card>
      
      {(isLoading || article) && (
        <Card className="flex flex-col">
          <CardHeader>
            <div className="flex justify-between items-center">
              <CardTitle>Generated Article</CardTitle>
              {article && (
                <Button variant="ghost" size="icon" onClick={handleCopy}>
                  <ClipboardCopy className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex-grow">
            {isLoading ? (
              <div className="flex h-full items-center justify-center">
                <div className="text-center">
                  <LoadingSpinner className="mx-auto h-12 w-12" />
                  <p className="mt-4 text-muted-foreground">Writing your article...</p>
                </div>
              </div>
            ) : (
              <Textarea
                readOnly
                value={article}
                className="h-full min-h-[400px] w-full resize-none whitespace-pre-wrap"
              />
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/code-generator/page.tsx
"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { generateCode } from "@/ai/flows/code-generator";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { ClipboardCopy } from "lucide-react";

const formSchema = z.object({
  description: z.string().min(10, { message: "Description must be at least 10 characters." }),
  language: z.string().min(1, { message: "Please select a language." }),
});

export default function CodeGeneratorPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [code, setCode] = useState("");
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      description: "",
      language: "typescript",
    },
  });

  const handleCopy = () => {
    navigator.clipboard.writeText(code).then(() => {
      toast({ title: "Copied to clipboard!" });
    });
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setCode("");
    try {
      const result = await generateCode(values);
      setCode(result.code);
    } catch (error) {
      console.error("Error generating code:", error);
      toast({
        title: "Error Generating Code",
        description: "There was an issue creating your code. Please check your details and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader>
          <CardTitle>Code Generator</CardTitle>
          <CardDescription>Generate code snippets in various languages based on your description.</CardDescription>
        </CardHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="description"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Description</FormLabel>
                    <FormControl>
                      <Textarea rows={6} placeholder="e.g., A React component for a login form with email and password fields." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="language"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Language</FormLabel>
                     <Select onValueChange={field.onChange} defaultValue={field.value}>
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Select a language" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        <SelectItem value="typescript">TypeScript</SelectItem>
                        <SelectItem value="javascript">JavaScript</SelectItem>
                        <SelectItem value="python">Python</SelectItem>
                        <SelectItem value="html">HTML</SelectItem>
                        <SelectItem value="css">CSS</SelectItem>
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading}>
                {isLoading && <LoadingSpinner className="mr-2" />}
                Generate Code
              </Button>
            </CardFooter>
          </form>
        </Form>
      </Card>
      
      {(isLoading || code) && (
        <Card className="flex flex-col">
          <CardHeader>
            <div className="flex justify-between items-center">
              <CardTitle>Generated Code</CardTitle>
              {code && (
                <Button variant="ghost" size="icon" onClick={handleCopy}>
                  <ClipboardCopy className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex-grow">
            {isLoading ? (
              <div className="flex h-full items-center justify-center">
                <div className="text-center">
                  <LoadingSpinner className="mx-auto h-12 w-12" />
                  <p className="mt-4 text-muted-foreground">Generating code...</p>
                </div>
              </div>
            ) : (
              <pre className="h-full min-h-[400px] w-full resize-none rounded-md bg-muted p-4 text-sm whitespace-pre-wrap font-code">
                <code>{code}</code>
              </pre>
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/content-creation/page.tsx
"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { generateContent } from "@/ai/flows/content-creation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { useToast } from "@/hooks/use-toast";
import { ClipboardCopy } from "lucide-react";

const formSchema = z.object({
  businessDescription: z.string().min(10, { message: "Description must be at least 10 characters." }),
});

// Define ContentOutput type locally as it cannot be exported from a 'use server' file.
type ContentOutput = {
  copy: string;
};

export default function ContentCreationPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [content, setContent] = useState<ContentOutput | null>(null);
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      businessDescription: "",
    },
  });

  const handleCopy = () => {
    if (content) {
      navigator.clipboard.writeText(content.copy).then(() => {
        toast({ title: "Copied to clipboard!" });
      });
    }
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setContent(null);
    try {
      const result = await generateContent(values);
      setContent(result);
    } catch (error) {
      console.error("Error generating content:", error);
      toast({
        title: "Error Generating Content",
        description: "There was an issue creating your content. Please check your details and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader>
          <CardTitle>Content Creation</CardTitle>
          <CardDescription>Generate marketing copy for your business.</CardDescription>
        </CardHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="businessDescription"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Business/Product Description</FormLabel>
                    <FormControl>
                      <Textarea rows={6} placeholder="e.g., A mobile app that helps users find the best local coffee shops." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading}>
                {isLoading && <LoadingSpinner className="mr-2" />}
                Generate Content
              </Button>
            </CardFooter>
          </form>
        </Form>
      </Card>
      
      {(isLoading || content) && (
        <Card className="flex flex-col">
          <CardHeader>
            <div className="flex justify-between items-center">
              <CardTitle>Generated Content</CardTitle>
              {content && (
                <Button variant="ghost" size="icon" onClick={handleCopy}>
                  <ClipboardCopy className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex-grow">
            {isLoading ? (
              <div className="flex h-full items-center justify-center">
                <div className="text-center">
                  <LoadingSpinner className="mx-auto h-12 w-12" />
                  <p className="mt-4 text-muted-foreground">Generating content...</p>
                </div>
              </div>
            ) : content && (
               <Textarea
                  readOnly
                  value={content.copy}
                  className="mt-1 h-full min-h-[300px] w-full resize-none whitespace-pre-wrap"
                />
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/email-responder/page.tsx
"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { generateEmailReply } from "@/ai/flows/email-responder";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { ClipboardCopy } from "lucide-react";

const formSchema = z.object({
  emailContent: z.string().min(10, { message: "Email content must be at least 10 characters." }),
  tone: z.string().min(1, { message: "Please select a tone." }),
});

export default function EmailResponderPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [reply, setReply] = useState("");
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      emailContent: "",
      tone: "professional",
    },
  });

  const handleCopy = () => {
    navigator.clipboard.writeText(reply).then(() => {
      toast({ title: "Copied to clipboard!" });
    });
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setReply("");
    try {
      const result = await generateEmailReply(values);
      setReply(result.reply);
    } catch (error) {
      console.error("Error generating reply:", error);
      toast({
        title: "Error Generating Reply",
        description: "There was an issue creating your email reply. Please check your details and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader>
          <CardTitle>Email Responder</CardTitle>
          <CardDescription>Generate professional or casual email replies in seconds.</CardDescription>
        </CardHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="emailContent"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Original Email Content</FormLabel>
                    <FormControl>
                      <Textarea rows={8} placeholder="Paste the content of the email you received here." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="tone"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Reply Tone</FormLabel>
                     <Select onValueChange={field.onChange} defaultValue={field.value}>
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Select a tone" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        <SelectItem value="professional">Professional</SelectItem>
                        <SelectItem value="casual">Casual</SelectItem>
                        <SelectItem value="friendly">Friendly</SelectItem>
                        <SelectItem value="direct">Direct</SelectItem>
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading}>
                {isLoading && <LoadingSpinner className="mr-2" />}
                Generate Reply
              </Button>
            </CardFooter>
          </form>
        </Form>
      </Card>
      
      {(isLoading || reply) && (
        <Card className="flex flex-col">
          <CardHeader>
            <div className="flex justify-between items-center">
              <CardTitle>Suggested Reply</CardTitle>
              {reply && (
                <Button variant="ghost" size="icon" onClick={handleCopy}>
                  <ClipboardCopy className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex-grow">
            {isLoading ? (
              <div className="flex h-full items-center justify-center">
                <div className="text-center">
                  <LoadingSpinner className="mx-auto h-12 w-12" />
                  <p className="mt-4 text-muted-foreground">Generating reply...</p>
                </div>
              </div>
            ) : (
              <Textarea
                readOnly
                value={reply}
                className="h-full min-h-[400px] w-full resize-none whitespace-pre-wrap"
              />
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/image-editor/page.tsx
"use client";

import { useState, useRef } from "react";
import Image from "next/image";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { realisticImageEditor } from "@/ai/flows/realistic-image-editor";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { Upload, Download } from "lucide-react";
import { useToast } from "@/hooks/use-toast";

const formSchema = z.object({
  photo: z.any().refine((files) => files?.length > 0, "Image is required."),
  editDescription: z.string().min(10, { message: "Description must be at least 10 characters." }),
});

export default function ImageEditorPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [originalImage, setOriginalImage] = useState<string | null>(null);
  const [editedImage, setEditedImage] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      editDescription: "",
    },
  });

  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      form.setValue("photo", event.target.files);
      const reader = new FileReader();
      reader.onloadend = () => {
        setOriginalImage(reader.result as string);
        setEditedImage(null);
      };
      reader.readAsDataURL(file);
    }
  };

  const toBase64 = (file: File): Promise<string> =>
    new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => resolve(reader.result as string);
      reader.onerror = (error) => reject(error);
    });

  const handleDownload = () => {
    if (editedImage) {
      const link = document.createElement("a");
      link.href = editedImage;
      link.download = "edited-image.png";
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    }
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setEditedImage(null);
    try {
      const photoDataUri = await toBase64(values.photo[0]);
      const result = await realisticImageEditor({
        photoDataUri,
        editDescription: values.editDescription,
      });
      setEditedImage(result.editedPhotoDataUri);
    } catch (error) {
      console.error("Error editing image:", error);
      toast({
        title: "Error Editing Image",
        description: "There was an issue editing your image. Please check your file, description, and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader>
          <CardTitle>Realistic Image Editor</CardTitle>
          <CardDescription>Upload an image and describe the edits you want to see.</CardDescription>
        </CardHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="photo"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Image</FormLabel>
                    <FormControl>
                      <div 
                        className="relative flex h-64 w-full cursor-pointer flex-col items-center justify-center rounded-lg border-2 border-dashed border-border bg-card hover:bg-muted"
                        onClick={() => fileInputRef.current?.click()}
                      >
                        <Input
                          type="file"
                          accept="image/*"
                          className="hidden"
                          ref={fileInputRef}
                          onChange={handleFileChange}
                        />
                        {originalImage ? (
                           <Image src={originalImage} alt="Original" layout="fill" objectFit="contain" className="rounded-lg" />
                        ) : (
                          <div className="text-center text-muted-foreground">
                            <Upload className="mx-auto h-12 w-12" />
                            <p className="mt-2">Click or drag file to this area to upload</p>
                            <p className="text-xs">PNG, JPG, GIF up to 10MB</p>
                          </div>
                        )}
                      </div>
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="editDescription"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Edit Description</FormLabel>
                    <FormControl>
                      <Textarea placeholder="e.g., Change the background to a sunny beach. Make the sky more blue." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading || !originalImage}>
                {isLoading && <LoadingSpinner className="mr-2" />}
                Edit Image
              </Button>
            </CardFooter>
          </form>
        </Form>
      </Card>
      
      {(isLoading || editedImage) && (
        <Card>
          <CardHeader>
             <div className="flex justify-between items-center">
              <CardTitle>Edited Image</CardTitle>
              {editedImage && (
                <Button variant="ghost" size="icon" onClick={handleDownload}>
                  <Download className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex h-full min-h-[400px] items-center justify-center">
            {isLoading ? (
              <div className="text-center">
                <LoadingSpinner className="mx-auto h-12 w-12" />
                <p className="mt-4 text-muted-foreground">Editing your image...</p>
              </div>
            ) : (
              editedImage && <Image src={editedImage} alt="Edited" width={500} height={500} className="rounded-lg object-contain" />
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/math-solver/page.tsx
"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { solveMathProblem } from "@/ai/flows/math-solver";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { useToast } from "@/hooks/use-toast";
import { ClipboardCopy } from "lucide-react";

const formSchema = z.object({
  problem: z.string().min(3, { message: "Problem must be at least 3 characters." }),
});

export default function MathSolverPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [solution, setSolution] = useState("");
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      problem: "",
    },
  });

  const handleCopy = () => {
    navigator.clipboard.writeText(solution).then(() => {
      toast({ title: "Copied to clipboard!" });
    });
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setSolution("");
    try {
      const result = await solveMathProblem(values);
      setSolution(result.solution);
    } catch (error) {
      console.error("Error solving problem:", error);
      toast({
        title: "Error Solving Problem",
        description: "There was an issue solving the problem. Please check your input and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader>
          <CardTitle>Math Solver</CardTitle>
          <CardDescription>Solve complex mathematical problems and equations.</CardDescription>
        </CardHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="problem"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Problem / Equation</FormLabel>
                    <FormControl>
                      <Input placeholder="e.g., solve 2x + 5 = 15 for x" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading}>
                {isLoading && <LoadingSpinner className="mr-2" />}
                Solve Problem
              </Button>
            </CardFooter>
          </form>
        </Form>
      </Card>
      
      {(isLoading || solution) && (
        <Card className="flex flex-col">
          <CardHeader>
            <div className="flex justify-between items-center">
              <CardTitle>Solution</CardTitle>
              {solution && (
                <Button variant="ghost" size="icon" onClick={handleCopy}>
                  <ClipboardCopy className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex-grow">
            {isLoading ? (
              <div className="flex h-full items-center justify-center">
                <div className="text-center">
                  <LoadingSpinner className="mx-auto h-12 w-12" />
                  <p className="mt-4 text-muted-foreground">Solving your problem...</p>
                </div>
              </div>
            ) : (
              <Textarea
                readOnly
                value={solution}
                className="h-full min-h-[400px] w-full resize-none whitespace-pre-wrap"
              />
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/report-generator/page.tsx
"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { generateAiReport } from "@/ai/flows/ai-report-generator";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { useToast } from "@/hooks/use-toast";
import { ClipboardCopy } from "lucide-react";

const formSchema = z.object({
  topic: z.string().min(10, { message: "Topic must be at least 10 characters long." }),
  referenceFormat: z.string().min(1, { message: "Please select a reference format." }),
});

export default function ReportGeneratorPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [report, setReport] = useState("");
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      topic: "",
      referenceFormat: "APA",
    },
  });

  const handleCopy = () => {
    navigator.clipboard.writeText(report).then(() => {
      toast({ title: "Copied to clipboard!" });
    });
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setReport("");
    try {
      const result = await generateAiReport(values);
      setReport(result.report);
    } catch (error) {
      console.error("Error generating report:", error);
      toast({
        title: "Error Generating Report",
        description: "There was an issue creating your report. Please check your details and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader>
          <CardTitle>AI Report Generator</CardTitle>
          <CardDescription>Generate a detailed report on any topic with proper citations.</CardDescription>
        </CardHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="topic"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Topic</FormLabel>
                    <FormControl>
                      <Input placeholder="e.g., The impact of AI on modern education" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="referenceFormat"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Reference Format</FormLabel>
                    <Select onValueChange={field.onChange} defaultValue={field.value}>
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Select a reference format" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        <SelectItem value="APA">APA</SelectItem>
                        <SelectItem value="MLA">MLA</SelectItem>
                        <SelectItem value="Chicago">Chicago</SelectItem>
                        <SelectItem value="Harvard">Harvard</SelectItem>
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading}>
                {isLoading && <LoadingSpinner className="mr-2" />}
                Generate Report
              </Button>
            </CardFooter>
          </form>
        </Form>
      </Card>
      
      {(isLoading || report) && (
        <Card className="flex flex-col">
          <CardHeader>
            <div className="flex justify-between items-center">
              <CardTitle>Generated Report</CardTitle>
              {report && (
                <Button variant="ghost" size="icon" onClick={handleCopy}>
                  <ClipboardCopy className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex-grow">
            {isLoading ? (
              <div className="flex h-full items-center justify-center">
                <div className="text-center">
                  <LoadingSpinner className="mx-auto h-12 w-12" />
                  <p className="mt-4 text-muted-foreground">Generating your report...</p>
                </div>
              </div>
            ) : (
              <Textarea
                readOnly
                value={report}
                className="h-full min-h-[400px] w-full resize-none whitespace-pre-wrap"
              />
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/resume-writer/page.tsx
"use client";

import { useState } from "react";
import { useForm, useFieldArray } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { writeResume } from "@/ai/flows/resume-writer";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { useToast } from "@/hooks/use-toast";
import { PlusCircle, Trash2, ClipboardCopy } from "lucide-react";

const workExperienceSchema = z.object({
  company: z.string().min(1, "Company is required."),
  role: z.string().min(1, "Role is required."),
  startDate: z.string().min(1, "Start date is required."),
  endDate: z.string().min(1, "End date is required."),
  description: z.string().min(10, "Description must be at least 10 characters."),
});

const educationSchema = z.object({
  institution: z.string().min(1, "Institution is required."),
  degree: z.string().min(1, "Degree is required."),
  startDate: z.string().min(1, "Start date is required."),
  endDate: z.string().min(1, "End date is required."),
});

const formSchema = z.object({
  fullName: z.string().min(2, "Full name is required."),
  email: z.string().email("Invalid email address."),
  phoneNumber: z.string().min(1, "Phone number is required."),
  address: z.string().min(1, "Address is required."),
  professionalSummary: z.string().min(20, "Summary must be at least 20 characters."),
  workExperience: z.array(workExperienceSchema),
  education: z.array(educationSchema),
  skills: z.string().min(1, "Please list at least one skill."),
});

export default function ResumeWriterPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [resume, setResume] = useState("");
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      fullName: "",
      email: "",
      phoneNumber: "",
      address: "",
      professionalSummary: "",
      workExperience: [{ company: "", role: "", startDate: "", endDate: "", description: "" }],
      education: [{ institution: "", degree: "", startDate: "", endDate: "" }],
      skills: "",
    },
  });

  const { fields: workFields, append: appendWork, remove: removeWork } = useFieldArray({
    control: form.control,
    name: "workExperience",
  });

  const { fields: eduFields, append: appendEdu, remove: removeEdu } = useFieldArray({
    control: form.control,
    name: "education",
  });

  const handleCopy = () => {
    navigator.clipboard.writeText(resume).then(() => {
      toast({ title: "Copied to clipboard!" });
    });
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setResume("");
    try {
      const result = await writeResume(values);
      setResume(result.resume);
    } catch (error) {
      console.error("Error writing resume:", error);
       toast({
        title: "Error Generating Resume",
        description: "There was an issue creating your resume. Please check your details and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card className="lg:col-span-2">
        <CardHeader>
          <CardTitle>Resume & CV Writer</CardTitle>
          <CardDescription>Fill in your details and let AI craft a professional resume for you.</CardDescription>
        </CardHeader>
      </Card>
      <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-6">
          <Card>
            <CardHeader><CardTitle>Personal Details</CardTitle></CardHeader>
            <CardContent className="space-y-4">
               <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <FormField control={form.control} name="fullName" render={({ field }) => ( <FormItem><FormLabel>Full Name</FormLabel><FormControl><Input placeholder="John Doe" {...field} /></FormControl><FormMessage /></FormItem> )} />
                <FormField control={form.control} name="email" render={({ field }) => ( <FormItem><FormLabel>Email</FormLabel><FormControl><Input placeholder="john.doe@example.com" {...field} /></FormControl><FormMessage /></FormItem> )} />
                <FormField control={form.control} name="phoneNumber" render={({ field }) => ( <FormItem><FormLabel>Phone Number</FormLabel><FormControl><Input placeholder="+1 (555) 123-4567" {...field} /></FormControl><FormMessage /></FormItem> )} />
                <FormField control={form.control} name="address" render={({ field }) => ( <FormItem><FormLabel>Address</FormLabel><FormControl><Input placeholder="123 Main St, Anytown, USA" {...field} /></FormControl><FormMessage /></FormItem> )} />
              </div>
            </CardContent>
          </Card>
           <Card>
            <CardHeader><CardTitle>Professional Summary</CardTitle></CardHeader>
            <CardContent>
              <FormField control={form.control} name="professionalSummary" render={({ field }) => ( <FormItem><FormLabel>Summary</FormLabel><FormControl><Textarea rows={5} placeholder="A brief summary of your career, skills, and goals..." {...field} /></FormControl><FormMessage /></FormItem> )} />
            </CardContent>
          </Card>
           <Card>
            <CardHeader><CardTitle>Work Experience</CardTitle></CardHeader>
            <CardContent className="space-y-4">
              {workFields.map((field, index) => (
                <div key={field.id} className="space-y-4 rounded-md border p-4 relative">
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <FormField control={form.control} name={`workExperience.${index}.role`} render={({ field }) => ( <FormItem><FormLabel>Role</FormLabel><FormControl><Input placeholder="Software Engineer" {...field} /></FormControl><FormMessage /></FormItem> )} />
                    <FormField control={form.control} name={`workExperience.${index}.company`} render={({ field }) => ( <FormItem><FormLabel>Company</FormLabel><FormControl><Input placeholder="Tech Corp" {...field} /></FormControl><FormMessage /></FormItem> )} />
                    <FormField control={form.control} name={`workExperience.${index}.startDate`} render={({ field }) => ( <FormItem><FormLabel>Start Date</FormLabel><FormControl><Input placeholder="Jan 2020" {...field} /></FormControl><FormMessage /></FormItem> )} />
                    <FormField control={form.control} name={`workExperience.${index}.endDate`} render={({ field }) => ( <FormItem><FormLabel>End Date</FormLabel><FormControl><Input placeholder="Present" {...field} /></FormControl><FormMessage /></FormItem> )} />
                  </div>
                  <FormField control={form.control} name={`workExperience.${index}.description`} render={({ field }) => ( <FormItem><FormLabel>Description</FormLabel><FormControl><Textarea placeholder="Describe your responsibilities and achievements..." {...field} /></FormControl><FormMessage /></FormItem> )} />
                  <Button type="button" variant="ghost" size="icon" className="absolute top-2 right-2" onClick={() => removeWork(index)}><Trash2 className="h-4 w-4" /></Button>
                </div>
              ))}
              <Button type="button" variant="outline" onClick={() => appendWork({ company: "", role: "", startDate: "", endDate: "", description: "" })}>
                <PlusCircle className="mr-2 h-4 w-4" /> Add Experience
              </Button>
            </CardContent>
          </Card>
          <Card>
            <CardHeader><CardTitle>Education</CardTitle></CardHeader>
            <CardContent className="space-y-4">
              {eduFields.map((field, index) => (
                <div key={field.id} className="space-y-4 rounded-md border p-4 relative">
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <FormField control={form.control} name={`education.${index}.degree`} render={({ field }) => ( <FormItem><FormLabel>Degree</FormLabel><FormControl><Input placeholder="B.S. in Computer Science" {...field} /></FormControl><FormMessage /></FormItem> )} />
                    <FormField control={form.control} name={`education.${index}.institution`} render={({ field }) => ( <FormItem><FormLabel>Institution</FormLabel><FormControl><Input placeholder="University of Technology" {...field} /></FormControl><FormMessage /></FormItem> )} />
                    <FormField control={form.control} name={`education.${index}.startDate`} render={({ field }) => ( <FormItem><FormLabel>Start Date</FormLabel><FormControl><Input placeholder="Sep 2016" {...field} /></FormControl><FormMessage /></FormItem> )} />
                    <FormField control={form.control} name={`education.${index}.endDate`} render={({ field }) => ( <FormItem><FormLabel>End Date</FormLabel><FormControl><Input placeholder="May 2020" {...field} /></FormControl><FormMessage /></FormItem> )} />
                  </div>
                   <Button type="button" variant="ghost" size="icon" className="absolute top-2 right-2" onClick={() => removeEdu(index)}><Trash2 className="h-4 w-4" /></Button>
                </div>
              ))}
              <Button type="button" variant="outline" onClick={() => appendEdu({ institution: "", degree: "", startDate: "", endDate: "" })}>
                <PlusCircle className="mr-2 h-4 w-4" /> Add Education
              </Button>
            </CardContent>
          </Card>
           <Card>
            <CardHeader><CardTitle>Skills</CardTitle></CardHeader>
            <CardContent>
              <FormField control={form.control} name="skills" render={({ field }) => ( <FormItem><FormLabel>Skills</FormLabel><FormControl><Textarea placeholder="Comma-separated skills, e.g., TypeScript, React, Node.js, Project Management" {...field} /></FormControl><FormMessage /></FormItem> )} />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading} size="lg">
                {isLoading && <LoadingSpinner className="mr-2" />}
                Generate Resume
              </Button>
            </CardFooter>
          </Card>
        </form>
      </Form>
      
      {(isLoading || resume) && (
        <Card className="flex flex-col lg:col-span-2">
          <CardHeader>
             <div className="flex justify-between items-center">
              <CardTitle>Generated Resume</CardTitle>
              {resume && (
                <Button variant="ghost" size="icon" onClick={handleCopy}>
                  <ClipboardCopy className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex-grow">
            {isLoading ? (
              <div className="flex h-full items-center justify-center">
                <div className="text-center">
                  <LoadingSpinner className="mx-auto h-12 w-12" />
                  <p className="mt-4 text-muted-foreground">Crafting your resume...</p>
                </div>
              </div>
            ) : (
              <Textarea
                readOnly
                value={resume}
                className="h-full min-h-[600px] w-full resize-none whitespace-pre-wrap font-mono"
              />
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/script-writer/page.tsx
"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { scriptWriter } from "@/ai/flows/script-writer";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { useToast } from "@/hooks/use-toast";
import { ClipboardCopy } from "lucide-react";

const formSchema = z.object({
  context: z.string().min(10, { message: "Context must be at least 10 characters." }),
  details: z.string().min(10, { message: "Details must be at least 10 characters." }),
});

export default function ScriptWriterPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [script, setScript] = useState("");
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      context: "",
      details: "A 5-minute YouTube video script. Target audience is young adults.",
    },
  });

  const handleCopy = () => {
    navigator.clipboard.writeText(script).then(() => {
      toast({ title: "Copied to clipboard!" });
    });
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setScript("");
    try {
      const result = await scriptWriter(values);
      setScript(result.script);
    } catch (error) {
      console.error("Error writing script:", error);
      toast({
        title: "Error Generating Script",
        description: "There was an issue creating your script. Please check your details and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader>
          <CardTitle>Script Writer</CardTitle>
          <CardDescription>Generate scripts for videos, podcasts, and more.</CardDescription>
        </CardHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="context"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Context</FormLabel>
                    <FormControl>
                      <Textarea rows={5} placeholder="e.g., A video about the history of the internet, focusing on the ARPANET." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="details"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Details</FormLabel>
                    <FormControl>
                      <Textarea rows={5} placeholder="e.g., Length, style, target audience, key talking points." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading}>
                {isLoading && <LoadingSpinner className="mr-2" />}
                Write Script
              </Button>
            </CardFooter>
          </form>
        </Form>
      </Card>
      
      {(isLoading || script) && (
        <Card className="flex flex-col">
          <CardHeader>
            <div className="flex justify-between items-center">
              <CardTitle>Generated Script</CardTitle>
              {script && (
                <Button variant="ghost" size="icon" onClick={handleCopy}>
                  <ClipboardCopy className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex-grow">
            {isLoading ? (
              <div className="flex h-full items-center justify-center">
                <div className="text-center">
                  <LoadingSpinner className="mx-auto h-12 w-12" />
                  <p className="mt-4 text-muted-foreground">Writing your script...</p>
                </div>
              </div>
            ) : (
              <Textarea
                readOnly
                value={script}
                className="h-full min-h-[400px] w-full resize-none whitespace-pre-wrap"
              />
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(app)'/social-media-post-generator/page.tsx
"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { generateSocialMediaPost } from "@/ai/flows/social-media-post-generator";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle } from "@/components/ui/card";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { LoadingSpinner } from "@/components/loading-spinner";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { ClipboardCopy } from "lucide-react";

const formSchema = z.object({
  topic: z.string().min(10, { message: "Topic must be at least 10 characters." }),
  platform: z.string().min(1, { message: "Please select a platform." }),
});

export default function SocialMediaPostGeneratorPage() {
  const [isLoading, setIsLoading] = useState(false);
  const [post, setPost] = useState("");
  const { toast } = useToast();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      topic: "",
      platform: "twitter",
    },
  });

  const handleCopy = () => {
    navigator.clipboard.writeText(post).then(() => {
      toast({ title: "Copied to clipboard!" });
    });
  };

  async function onSubmit(values: z.infer<typeof formSchema>) {
    setIsLoading(true);
    setPost("");
    try {
      const result = await generateSocialMediaPost(values);
      setPost(result.post);
    } catch (error) {
      console.error("Error generating post:", error);
      toast({
        title: "Error Generating Post",
        description: "There was an issue creating your post. Please check your details and API key, then try again.",
        variant: "destructive",
      });
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader>
          <CardTitle>Social Media Post Generator</CardTitle>
          <CardDescription>Create engaging social media posts for various platforms.</CardDescription>
        </CardHeader>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)}>
            <CardContent className="space-y-4">
              <FormField
                control={form.control}
                name="topic"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Topic / Message</FormLabel>
                    <FormControl>
                      <Textarea rows={6} placeholder="e.g., Announcing a new product feature that allows users to collaborate in real-time." {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="platform"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Platform</FormLabel>
                     <Select onValueChange={field.onChange} defaultValue={field.value}>
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Select a platform" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        <SelectItem value="twitter">Twitter / X</SelectItem>
                        <SelectItem value="facebook">Facebook</SelectItem>
                        <SelectItem value="linkedin">LinkedIn</SelectItem>
                        <SelectItem value="instagram">Instagram</SelectItem>
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />
            </CardContent>
            <CardFooter>
              <Button type="submit" disabled={isLoading}>
                {isLoading && <LoadingSpinner className="mr-2" />}
                Generate Post
              </Button>
            </CardFooter>
          </form>
        </Form>
      </Card>
      
      {(isLoading || post) && (
        <Card className="flex flex-col">
          <CardHeader>
            <div className="flex justify-between items-center">
              <CardTitle>Generated Post</CardTitle>
              {post && (
                <Button variant="ghost" size="icon" onClick={handleCopy}>
                  <ClipboardCopy className="h-4 w-4" />
                </Button>
              )}
            </div>
          </CardHeader>
          <CardContent className="flex-grow">
            {isLoading ? (
              <div className="flex h-full items-center justify-center">
                <div className="text-center">
                  <LoadingSpinner className="mx-auto h-12 w-12" />
                  <p className="mt-4 text-muted-foreground">Generating post...</p>
                </div>
              </div>
            ) : (
              <Textarea
                readOnly
                value={post}
                className="h-full min-h-[400px] w-full resize-none whitespace-pre-wrap"
              />
            )}
          </CardContent>
        </Card>
      )}
    </div>
  );
}
EOF

# src/app/(auth) layout and pages
cat <<'EOF' > src/app/'(auth)'/layout.tsx
export default function AuthLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center bg-background p-4">
      {children}
    </div>
  );
}
EOF

cat <<'EOF' > src/app/'(auth)'/login/page.tsx
"use client";

import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { KeizerLogo } from "@/components/keizer-logo";
import { useRouter } from "next/navigation";

export default function LoginPage() {
  const router = useRouter();

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    // Placeholder for login logic
    router.push("/dashboard");
  };

  return (
    <Card className="mx-auto max-w-sm">
      <CardHeader className="text-center">
        <KeizerLogo className="mx-auto h-12 w-12" />
        <CardTitle className="text-2xl mt-4">Welcome Back!</CardTitle>
        <CardDescription>Enter your credentials to access your account</CardDescription>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleLogin} className="grid gap-4">
          <div className="grid gap-2">
            <Label htmlFor="email">Email</Label>
            <Input id="email" type="email" placeholder="m@example.com" required />
          </div>
          <div className="grid gap-2">
            <div className="flex items-center">
              <Label htmlFor="password">Password</Label>
              <Link href="#" className="ml-auto inline-block text-sm underline">
                Forgot your password?
              </Link>
            </div>
            <Input id="password" type="password" required />
          </div>
          <Button type="submit" className="w-full">
            Login
          </Button>
        </form>
        <div className="mt-4 text-center text-sm">
          Don&apos;t have an account?{" "}
          <Link href="/signup" className="underline">
            Sign up
          </Link>
        </div>
      </CardContent>
    </Card>
  );
}
EOF

cat <<'EOF' > src/app/'(auth)'/signup/page.tsx
"use client";

import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { KeizerLogo } from "@/components/keizer-logo";
import { useRouter } from "next/navigation";

export default function SignupPage() {
  const router = useRouter();

  const handleSignup = (e: React.FormEvent) => {
    e.preventDefault();
    // Placeholder for signup logic
    router.push("/dashboard");
  };

  return (
    <Card className="mx-auto max-w-sm">
      <CardHeader className="text-center">
        <KeizerLogo className="mx-auto h-12 w-12" />
        <CardTitle className="text-2xl mt-4">Create an Account</CardTitle>
        <CardDescription>Enter your information to create an account</CardDescription>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSignup} className="grid gap-4">
          <div className="grid gap-2">
            <Label htmlFor="full-name">Full Name</Label>
            <Input id="full-name" placeholder="Keizer AI" required />
          </div>
          <div className="grid gap-2">
            <Label htmlFor="email">Email</Label>
            <Input id="email" type="email" placeholder="m@example.com" required />
          </div>
          <div className="grid gap-2">
            <Label htmlFor="password">Password</Label>
            <Input id="password" type="password" required />
          </div>
          <Button type="submit" className="w-full">
            Create account
          </Button>
        </form>
        <div className="mt-4 text-center text-sm">
          Already have an account?{" "}
          <Link href="/login" className="underline">
            Login
          </Link>
        </div>
      </CardContent>
    </Card>
  );
}
EOF

# src/ai
cat <<'EOF' > src/ai/genkit.ts
import {genkit} from 'genkit';
import {googleAI} from '@genkit-ai/googleai';
import { defineSecret } from 'genkit/secrets';

// This tells Genkit that the API key is stored in a secret manager.
// For local development, it will look for a .env.local file.
// For Vercel/Firebase, this is managed in their dashboards.
defineSecret({
  id: 'GOOGLE_API_KEY',
  description: 'The Google AI API key',
});

export const ai = genkit({
  plugins: [
    googleAI({
      apiKey: process.env.GOOGLE_API_KEY,
    }),
  ],
  model: 'googleai/gemini-2.0-flash',
});
EOF

cat <<'EOF' > src/ai/dev.ts
import { config } from 'dotenv';
config();

import '@/ai/flows/article-writer.ts';
import '@/ai/flows/ai-report-generator.ts';
import '@/ai/flows/script-writer.ts';
import '@/ai/flows/realistic-image-editor.ts';
import '@/ai/flows/content-creation.ts';
import '@/ai/flows/math-solver.ts';
import '@/ai/flows/chat-flow.ts';
import '@/ai/flows/code-generator.ts';
import '@/ai/flows/email-responder.ts';
import '@/ai/flows/social-media-post-generator.ts';
import '@/ai/flows/resume-writer.ts';
EOF

# src/ai/flows
cat <<'EOF' > src/ai/flows/ai-report-generator.ts
// This is an autogenerated file from Firebase Studio.

'use server';

/**
 * @fileOverview A flow for generating AI reports based on a given topic and reference format.
 *
 * - generateAiReport - A function that generates an AI report.
 * - GenerateAiReportInput - The input type for the generateAiReport function.
 * - GenerateAiReportOutput - The return type for the generateAiReport function.
 */

import {ai} from '@/ai/genkit';
import {z} from 'genkit';

const GenerateAiReportInputSchema = z.object({
  topic: z.string().describe('The topic for the AI report.'),
  referenceFormat: z
    .string()
    .describe(
      'The reference format for the report (e.g., MLA, APA, Chicago).' +
        'If unspecified, the reference format will be omitted.'
    ),
});
type GenerateAiReportInput = z.infer<typeof GenerateAiReportInputSchema>;

const GenerateAiReportOutputSchema = z.object({
  report: z.string().describe('The generated AI report.'),
});
type GenerateAiReportOutput = z.infer<typeof GenerateAiReportOutputSchema>;

export async function generateAiReport(
  input: GenerateAiReportInput
): Promise<GenerateAiReportOutput> {
  return generateAiReportFlow(input);
}

const prompt = ai.definePrompt({
  name: 'generateAiReportPrompt',
  input: {schema: GenerateAiReportInputSchema},
  output: {schema: GenerateAiReportOutputSchema},
  prompt: `You are an expert research assistant. Your task is to generate a comprehensive and well-structured report on the given topic.

The report must be detailed, insightful, and at least 500 words long. It should be formatted professionally and include the following sections:
1.  **Introduction:** Briefly introduce the topic and the scope of the report.
2.  **Main Body:** Provide a thorough analysis of the topic, broken down into multiple paragraphs or sub-sections. Use data and evidence to support your points where applicable.
3.  **Conclusion:** Summarize the key findings of the report.
4.  **References:** If applicable, list any sources used, formatted according to the specified reference style.

Topic: {{{topic}}}
Reference Format: {{{referenceFormat}}}

Generate the full report now.
`,
});

const generateAiReportFlow = ai.defineFlow(
  {
    name: 'generateAiReportFlow',
    inputSchema: GenerateAiReportInputSchema,
    outputSchema: GenerateAiReportOutputSchema,
  },
  async input => {
    const {output} = await prompt(input);
    return output!;
  }
);
EOF

cat <<'EOF' > src/ai/flows/article-writer.ts
'use server';

/**
 * @fileOverview Article and journal writer AI agent.
 *
 * - writeArticle - A function that handles the article writing process.
 * - WriteArticleInput - The input type for the writeArticle function.
 * - WriteArticleOutput - The return type for the writeArticle function.
 */

import {ai} from '@/ai/genkit';
import {z} from 'genkit';

const WriteArticleInputSchema = z.object({
  topic: z.string().describe('The topic of the article or journal.'),
  context: z.string().describe('Additional context or information to guide the writing.'),
  style: z.string().describe('Requirements for the article style, such as tone and citations.'),
});
type WriteArticleInput = z.infer<typeof WriteArticleInputSchema>;

const WriteArticleOutputSchema = z.object({
  article: z.string().describe('The generated article or journal content.'),
});
type WriteArticleOutput = z.infer<typeof WriteArticleOutputSchema>;

export async function writeArticle(input: WriteArticleInput): Promise<WriteArticleOutput> {
  return writeArticleFlow(input);
}

const prompt = ai.definePrompt({
  name: 'writeArticlePrompt',
  input: {schema: WriteArticleInputSchema},
  output: {schema: WriteArticleOutputSchema},
  prompt: `You are an AI assistant specialized in writing articles and journals.

You will use the provided topic, context, and style requirements to generate the content.

Topic: {{{topic}}}
Context: {{{context}}}
Style Requirements: {{{style}}}

Write the article or journal based on the above information.`,
});

const writeArticleFlow = ai.defineFlow(
  {
    name: 'writeArticleFlow',
    inputSchema: WriteArticleInputSchema,
    outputSchema: WriteArticleOutputSchema,
  },
  async input => {
    const {output} = await prompt(input);
    return output!;
  }
);
EOF

cat <<'EOF' > src/ai/flows/chat-flow.ts
'use server';
/**
 * @fileOverview A conversational AI flow for the chat interface.
 *
 * - chat - A function that takes chat history and returns a response.
 * - ChatInput - The input type for the chat function.
 * - ChatOutput - The return type for the chat function.
 * - ChatMessage - A single message object in the chat history.
 */

import { ai } from '@/ai/genkit';
import { z } from 'genkit';

const ChatMessageSchema = z.object({
  role: z.enum(['user', 'model']),
  content: z.string(),
});
export type ChatMessage = z.infer<typeof ChatMessageSchema>;

const ChatInputSchema = z.object({
  history: z.array(ChatMessageSchema),
});
export type ChatInput = z.infer<typeof ChatInputSchema>;

const ChatOutputSchema = z.object({
  reply: z.string().describe("The AI's response to the user."),
});
export type ChatOutput = z.infer<typeof ChatOutputSchema>;

export async function chat({ history }: ChatInput): Promise<ChatOutput> {
  // Validate that history is a non-empty array before proceeding.
  if (!Array.isArray(history) || history.length === 0) {
    const errorMsg = 'Chat history is invalid or empty.';
    console.error(errorMsg, history);
    return { reply: `An internal error occurred: ${errorMsg}` };
  }

  // The last message in the history is the user's current prompt.
  const lastMessage = history[history.length - 1];

  // The rest of the array is the conversational history.
  const conversationHistory = history.slice(0, -1);
  
  // The model requires a user message to start the conversation.
  // We ensure the last message is from the user.
  if (lastMessage.role !== 'user') {
    const errorMsg = 'The final message in the history must be from the user.';
    console.error(errorMsg, history);
    return { reply: `An internal error occurred: ${errorMsg}` };
  }

  try {
    // Generate a response using the provided history and the user's prompt.
    const response = await ai.generate({
      system: `You are Keizer, a friendly, witty, and highly intelligent AI assistant. Your goal is to be as helpful as possible while maintaining an engaging and slightly playful personality.`,
      // The history needs to be mapped to the specific format the AI model expects.
      history: conversationHistory.map((msg) => ({
        role: msg.role,
        content: [{ text: msg.content }],
      })),
      // The content of the last message is the actual prompt for the AI.
      prompt: lastMessage.content,
    });

    // Ensure a string is always returned to prevent client-side errors.
    return {
      reply: response.text ?? 'I seem to be at a loss for words. Please try again.',
    };
  } catch (error)
  {
    console.error('Error during AI generation in chat flow:', error);
    // Provide a user-friendly error message on failure.
    return { reply: 'Sorry, I encountered an error generating a response. The AI model may be temporarily unavailable.' };
  }
}
EOF

cat <<'EOF' > src/ai/flows/code-generator.ts
'use server';
/**
 * @fileOverview An AI agent for generating code snippets.
 *
 * - generateCode - A function that generates code.
 * - GenerateCodeInput - The input type for the generateCode function.
 * - GenerateCodeOutput - The return type for the generateCode function.
 */

import { ai } from '@/ai/genkit';
import { z } from 'genkit';

const GenerateCodeInputSchema = z.object({
  description: z.string().describe('A description of the code to generate.'),
  language: z.string().describe('The programming language for the code snippet.'),
});
type GenerateCodeInput = z.infer<typeof GenerateCodeInputSchema>;

const GenerateCodeOutputSchema = z.object({
  code: z.string().describe('The generated code snippet.'),
});
type GenerateCodeOutput = z.infer<typeof GenerateCodeOutputSchema>;

export async function generateCode(input: GenerateCodeInput): Promise<GenerateCodeOutput> {
  return generateCodeFlow(input);
}

const prompt = ai.definePrompt({
  name: 'generateCodePrompt',
  input: { schema: GenerateCodeInputSchema },
  output: { schema: GenerateCodeOutputSchema },
  prompt: `You are an expert programmer. Generate a code snippet based on the following description and language.
Only output the code, without any explanation or markdown formatting.

Language: {{{language}}}
Description: {{{description}}}
`,
});

const generateCodeFlow = ai.defineFlow(
  {
    name: 'generateCodeFlow',
    inputSchema: GenerateCodeInputSchema,
    outputSchema: GenerateCodeOutputSchema,
  },
  async (input) => {
    const { output } = await prompt(input);
    return output!;
  }
);
EOF

cat <<'EOF' > src/ai/flows/content-creation.ts
// Content Creation flow
'use server';
/**
 * @fileOverview Generates marketing and website copy based on a brief user description.
 *
 * - generateContent - A function that generates content.
 * - ContentInput - The input type for the generateContent function.
 * - ContentOutput - The return type for the generateContent function.
 */

import {ai} from '@/ai/genkit';
import {z} from 'genkit';

const ContentInputSchema = z.object({
  businessDescription: z
    .string()
    .describe('A brief description of the business or product.'),
});
type ContentInput = z.infer<typeof ContentInputSchema>;

const ContentOutputSchema = z.object({
  copy: z.string().describe('The generated marketing and website copy.'),
});
type ContentOutput = z.infer<typeof ContentOutputSchema>;

export async function generateContent(input: ContentInput): Promise<ContentOutput> {
  return contentCreationFlow(input);
}

const contentCreationPrompt = ai.definePrompt({
  name: 'contentCreationPrompt',
  input: {schema: ContentInputSchema},
  output: {schema: ContentOutputSchema},
  prompt: `You are a marketing expert. Create compelling marketing and website copy based on the following description.

Description: {{{businessDescription}}}

Output the marketing copy in JSON format.`,
  config: {
    safetySettings: [
      {
        category: 'HARM_CATEGORY_HATE_SPEECH',
        threshold: 'BLOCK_ONLY_HIGH',
      },
      {
        category: 'HARM_CATEGORY_DANGEROUS_CONTENT',
        threshold: 'BLOCK_NONE',
      },
      {
        category: 'HARM_CATEGORY_HARASSMENT',
        threshold: 'BLOCK_MEDIUM_AND_ABOVE',
      },
      {
        category: 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
        threshold: 'BLOCK_LOW_AND_ABOVE',
      },
    ],
  },
});

const contentCreationFlow = ai.defineFlow(
  {
    name: 'contentCreationFlow',
    inputSchema: ContentInputSchema,
    outputSchema: ContentOutputSchema,
  },
  async input => {
    const {output} = await contentCreationPrompt(input);
    return output!;
  }
);
EOF

cat <<'EOF' > src/ai/flows/email-responder.ts
'use server';
/**
 * @fileOverview An AI agent for generating email replies.
 *
 * - generateEmailReply - A function that generates an email reply.
 * - GenerateEmailReplyInput - The input type for the generateEmailReply function.
 * - GenerateEmailReplyOutput - The return type for the generateEmailReply function.
 */

import { ai } from '@/ai/genkit';
import { z } from 'genkit';

const GenerateEmailReplyInputSchema = z.object({
  emailContent: z.string().describe('The content of the original email.'),
  tone: z.string().describe('The desired tone for the reply (e.g., professional, casual).'),
});
type GenerateEmailReplyInput = z.infer<typeof GenerateEmailReplyInputSchema>;

const GenerateEmailReplyOutputSchema = z.object({
  reply: z.string().describe('The generated email reply.'),
});
type GenerateEmailReplyOutput = z.infer<typeof GenerateEmailReplyOutputSchema>;

export async function generateEmailReply(input: GenerateEmailReplyInput): Promise<GenerateEmailReplyOutput> {
  return generateEmailReplyFlow(input);
}

const prompt = ai.definePrompt({
  name: 'generateEmailReplyPrompt',
  input: { schema: GenerateEmailReplyInputSchema },
  output: { schema: GenerateEmailReplyOutputSchema },
  prompt: `You are a helpful assistant that writes email replies.
Based on the original email content and desired tone, write a suitable reply.

Original Email:
{{{emailContent}}}

Desired Tone: {{{tone}}}
`,
});

const generateEmailReplyFlow = ai.defineFlow(
  {
    name: 'generateEmailReplyFlow',
    inputSchema: GenerateEmailReplyInputSchema,
    outputSchema: GenerateEmailReplyOutputSchema,
  },
  async (input) => {
    const { output } = await prompt(input);
    return output!;
  }
);
EOF

cat <<'EOF' > src/ai/flows/math-solver.ts
'use server';

/**
 * @fileOverview Math problem solver AI agent.
 *
 * - solveMathProblem - A function that handles solving mathematical problems.
 * - MathSolverInput - The input type for the solveMathProblem function.
 * - MathSolverOutput - The return type for the solveMathProblem function.
 */

import {ai} from '@/ai/genkit';
import {z} from 'genkit';

const MathSolverInputSchema = z.object({
  problem: z.string().describe('The mathematical problem or equation to solve.'),
});
type MathSolverInput = z.infer<typeof MathSolverInputSchema>;

const MathSolverOutputSchema = z.object({
  solution: z.string().describe('The solution to the mathematical problem, with steps if possible.'),
});
type MathSolverOutput = z.infer<typeof MathSolverOutputSchema>;

export async function solveMathProblem(input: MathSolverInput): Promise<MathSolverOutput> {
  return mathSolverFlow(input);
}

const prompt = ai.definePrompt({
  name: 'mathSolverPrompt',
  input: {schema: MathSolverInputSchema},
  output: {schema: MathSolverOutputSchema},
  prompt: `You are a powerful AI math solver. Your specialty is symbolic manipulation of equations.
Solve the following mathematical problem. Provide a step-by-step solution if applicable.

Problem: {{{problem}}}
`,
});

const mathSolverFlow = ai.defineFlow(
  {
    name: 'mathSolverFlow',
    inputSchema: MathSolverInputSchema,
    outputSchema: MathSolverOutputSchema,
  },
  async input => {
    const {output} = await prompt(input);
    return output!;
  }
);
EOF

cat <<'EOF' > src/ai/flows/realistic-image-editor.ts
// Realistic Image Editor
'use server';

/**
 * @fileOverview An AI agent for realistically editing images based on user descriptions.
 *
 * - realisticImageEditor - A function that handles the image editing process.
 * - RealisticImageEditorInput - The input type for the realisticImageEditor function.
 * - RealisticImageEditorOutput - The return type for the realisticImageEditor function.
 */

import {ai} from '@/ai/genkit';
import {z} from 'genkit';

const RealisticImageEditorInputSchema = z.object({
  photoDataUri: z
    .string()
    .describe(
      "A photo to edit, as a data URI that must include a MIME type and use Base64 encoding. Expected format: 'data:<mimetype>;base64,<encoded_data>'."
    ),
  editDescription: z.string().describe('The description of the edits to perform on the image.'),
});
type RealisticImageEditorInput = z.infer<typeof RealisticImageEditorInputSchema>;

const RealisticImageEditorOutputSchema = z.object({
  editedPhotoDataUri: z.string().describe('The edited photo, as a data URI.'),
});
type RealisticImageEditorOutput = z.infer<typeof RealisticImageEditorOutputSchema>;

export async function realisticImageEditor(input: RealisticImageEditorInput): Promise<RealisticImageEditorOutput> {
  return realisticImageEditorFlow(input);
}

const prompt = ai.definePrompt({
  name: 'realisticImageEditorPrompt',
  input: {schema: RealisticImageEditorInputSchema},
  output: {schema: RealisticImageEditorOutputSchema},
  prompt: `You are an expert photo editor. A user has provided an image and a description of the edits they want to perform.

  Original Photo: {{media url=photoDataUri}}
  Edits: {{{editDescription}}}

  Create an edited version of the photo with the specified edits.
  Ensure that the result looks realistic and natural.
  Return the edited photo as a data URI.
`,
});

const realisticImageEditorFlow = ai.defineFlow(
  {
    name: 'realisticImageEditorFlow',
    inputSchema: RealisticImageEditorInputSchema,
    outputSchema: RealisticImageEditorOutputSchema,
  },
  async input => {
    const {media} = await ai.generate({
      model: 'googleai/gemini-2.0-flash-preview-image-generation',
      prompt: [
        {media: {url: input.photoDataUri}},
        {text: input.editDescription},
      ],
      config: {
        responseModalities: ['TEXT', 'IMAGE'],
      },
    });
    return {editedPhotoDataUri: media!.url!};
  }
);
EOF

cat <<'EOF' > src/ai/flows/resume-writer.ts
'use server';
/**
 * @fileOverview An AI agent for writing professional resumes and CVs.
 *
 * - writeResume - A function that generates a resume.
 * - WriteResumeInput - The input type for the writeResume function.
 * - WriteResumeOutput - The return type for the writeResume function.
 */

import { ai } from '@/ai/genkit';
import { z } from 'genkit';

const WorkExperienceSchema = z.object({
  company: z.string().describe('The name of the company.'),
  role: z.string().describe('The job title or role.'),
  startDate: z.string().describe('The start date of the employment.'),
  endDate: z.string().describe('The end date of the employment (or "Present").'),
  description: z.string().describe('A description of responsibilities and achievements in the role.'),
});

const EducationSchema = z.object({
  institution: z.string().describe('The name of the educational institution.'),
  degree: z.string().describe('The degree or qualification obtained.'),
  startDate: z.string().describe('The start date of the education.'),
  endDate: z.string().describe('The end date of the education.'),
});

const WriteResumeInputSchema = z.object({
  fullName: z.string().describe('The full name of the applicant.'),
  email: z.string().email().describe('The email address of the applicant.'),
  phoneNumber: z.string().describe('The phone number of the applicant.'),
  address: z.string().describe('The physical address of the applicant.'),
  professionalSummary: z.string().describe('A brief professional summary or objective.'),
  workExperience: z.array(WorkExperienceSchema).describe('A list of work experiences.'),
  education: z.array(EducationSchema).describe('A list of educational qualifications.'),
  skills: z.string().describe('A comma-separated list of relevant skills.'),
});
type WriteResumeInput = z.infer<typeof WriteResumeInputSchema>;

const WriteResumeOutputSchema = z.object({
  resume: z.string().describe('The generated resume content in Markdown format.'),
});
type WriteResumeOutput = z.infer<typeof WriteResumeOutputSchema>;

export async function writeResume(input: WriteResumeInput): Promise<WriteResumeOutput> {
  return writeResumeFlow(input);
}

const prompt = ai.definePrompt({
  name: 'writeResumePrompt',
  input: { schema: WriteResumeInputSchema },
  output: { schema: WriteResumeOutputSchema },
  prompt: `You are an expert resume writer and career coach. Your task is to create a professional and compelling resume in Markdown format based on the information provided.

The resume should be well-structured, easy to read, and highlight the applicant's strengths. Use professional language and action verbs.

Format the output strictly in Markdown. Start with the applicant's name and contact information, followed by the professional summary, work experience, education, and skills sections.

**Applicant Details:**
- **Full Name:** {{{fullName}}}
- **Contact:** {{{email}}} | {{{phoneNumber}}} | {{{address}}}

**Professional Summary:**
{{{professionalSummary}}}

**Work Experience:**
{{#each workExperience}}
- **{{role}}** at {{company}} ({{startDate}} - {{endDate}})
  - {{description}}
{{/each}}

**Education:**
{{#each education}}
- **{{degree}}**, {{institution}} ({{startDate}} - {{endDate}})
{{/each}}

**Skills:**
{{{skills}}}

Generate the complete resume now.
`,
});

const writeResumeFlow = ai.defineFlow(
  {
    name: 'writeResumeFlow',
    inputSchema: WriteResumeInputSchema,
    outputSchema: WriteResumeOutputSchema,
  },
  async (input) => {
    const { output } = await prompt(input);
    return output!;
  }
);
EOF

cat <<'EOF' > src/ai/flows/script-writer.ts
'use server';

/**
 * @fileOverview Script writing AI agent.
 *
 * - scriptWriter - A function that handles the script writing process.
 * - ScriptWriterInput - The input type for the scriptWriter function.
 * - ScriptWriterOutput - The return type for the scriptWriter function.
 */

import {ai} from '@/ai/genkit';
import {z} from 'genkit';

const ScriptWriterInputSchema = z.object({
  context: z.string().describe('The context or background information for the script.'),
  details: z.string().describe('Specific details or requirements for the script, such as length, style, and target audience.'),
});
type ScriptWriterInput = z.infer<typeof ScriptWriterInputSchema>;

const ScriptWriterOutputSchema = z.object({
  script: z.string().describe('The generated script.'),
});
type ScriptWriterOutput = z.infer<typeof ScriptWriterOutputSchema>;

export async function scriptWriter(input: ScriptWriterInput): Promise<ScriptWriterOutput> {
  return scriptWriterFlow(input);
}

const prompt = ai.definePrompt({
  name: 'scriptWriterPrompt',
  input: {schema: ScriptWriterInputSchema},
  output: {schema: ScriptWriterOutputSchema},
  prompt: `You are an AI script writing assistant. Use the following context and details to create a script.

Context: {{{context}}}
Details: {{{details}}}

Script:`,
});

const scriptWriterFlow = ai.defineFlow(
  {
    name: 'scriptWriterFlow',
    inputSchema: ScriptWriterInputSchema,
    outputSchema: ScriptWriterOutputSchema,
  },
  async input => {
    const {output} = await prompt(input);
    return output!;
  }
);
EOF

cat <<'EOF' > src/ai/flows/social-media-post-generator.ts
'use server';
/**
 * @fileOverview An AI agent for generating social media posts.
 *
 * - generateSocialMediaPost - A function that generates a social media post.
 * - GenerateSocialMediaPostInput - The input type for the generateSocialMediaPost function.
 * - GenerateSocialMediaPostOutput - The return type for the generateSocialMediaPost function.
 */

import { ai } from '@/ai/genkit';
import { z } from 'genkit';

const GenerateSocialMediaPostInputSchema = z.object({
  topic: z.string().describe('The topic or message for the social media post.'),
  platform: z.string().describe('The target social media platform (e.g., Twitter, Facebook).'),
});
type GenerateSocialMediaPostInput = z.infer<typeof GenerateSocialMediaPostInputSchema>;

const GenerateSocialMediaPostOutputSchema = z.object({
  post: z.string().describe('The generated social media post content.'),
});
type GenerateSocialMediaPostOutput = z.infer<typeof GenerateSocialMediaPostOutputSchema>;

export async function generateSocialMediaPost(input: GenerateSocialMediaPostInput): Promise<GenerateSocialMediaPostOutput> {
  return generateSocialMediaPostFlow(input);
}

const prompt = ai.definePrompt({
  name: 'generateSocialMediaPostPrompt',
  input: { schema: GenerateSocialMediaPostInputSchema },
  output: { schema: GenerateSocialMediaPostOutputSchema },
  prompt: `You are a social media marketing expert. Create an engaging social media post for the specified platform based on the given topic.
Include relevant hashtags.

Platform: {{{platform}}}
Topic: {{{topic}}}
`,
});

const generateSocialMediaPostFlow = ai.defineFlow(
  {
    name: 'generateSocialMediaPostFlow',
    inputSchema: GenerateSocialMediaPostInputSchema,
    outputSchema: GenerateSocialMediaPostOutputSchema,
  },
  async (input) => {
    const { output } = await prompt(input);
    return output!;
  }
);
EOF


echo "All files created successfully."
echo ""
echo "--------------------------------------------------------"
echo "Next Steps: Push to GitHub"
echo "--------------------------------------------------------"
echo "Your project files are now ready in this Replit environment."
echo "Follow these steps in the Shell to get your code on GitHub:"
echo ""
echo "1. Configure Git with your details (only need to do this once):"
echo '   git config --global user.name "Your Name"'
echo '   git config --global user.email "your.email@example.com"'
echo ""
echo "2. Create a new, EMPTY repository on GitHub.com."
echo "   DO NOT add a README, license, or .gitignore file."
echo ""
echo "3. Link this project to your new GitHub repository. Replace the URL:"
echo "   git init -b main"
echo "   git remote add origin https://github.com/YourUsername/YourRepoName.git"
echo ""
echo "4. Add all files, commit them, and push them to GitHub:"
echo "   git add ."
echo '   git commit -m "Initial commit from Replit"'
echo "   git push -u origin main"
echo ""
echo "After this, you can connect your GitHub repo to Vercel to deploy!"
